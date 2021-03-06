### plot your ellipses
want_samps = 25
print("Add in a filter statement we show the same amount at each station")

all_ellipses = NULL
for(use_id in 1:7){

  file_name = paste("helper/maxstable_region_", use_id, ".rds", sep = "")
  model_list = readRDS(file_name)

  # get the medoid
  print("CAUTION fit info needs initialising properly")
  medoid <- fit_info[medoid_indexes[use_id], ]

  ellipse_df <- get_ellipse_from_smith_model_fits(model_list, medoid = medoid) %>%
    mutate(region_id = use_id)

  all_ellipses = rbind(all_ellipses, ellipse_df)

}

# -----------------------------------------------------------------------------

all_ellipses <- all_ellipses %>%
  mutate(plot_index = paste(region_id, sim_index))

# plot elliptical curves
ell_plot <- ggplot(data = all_ellipses) +
  geom_path(aes(x=x, y =y, group = plot_index), alpha = 0.25) +
  theme_bw()
ell_plot

# # -----------------------------------------------------------------------------
#
# check_ellipses <- left_join(check_ellipses, ellipse_df, by = "sim_index")
#
# # plot elliptical curves
# ell_plot <- ggplot() +
#   geom_path(data = ellipse_df, aes(x=x, y =y, group = sim_index), alpha = 0.25) +
#   geom_path(data = check_ellipses, aes(x=x, y =y,
#                                        group = sim_index, col = as.factor(sim_index))) +
#   theme_bw()
# ell_plot
#
# library(plotly)
# ggplotly(ell_plot)
