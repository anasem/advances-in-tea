source("scripts/0-theme.R")

water_calib_data <- readRDS(file = "data/rds/water_calibration_data.rds")

water_correction_plot <- 
 ggplot(water_calib_data) + 
    geom_point(aes(H2O_ppm, CO2_ppm, col = "none"), 
               alpha = .7, size = 1.3, pch = 16, stroke = 0) +
    geom_point(aes(H2O_ppm, CO2_dry_ppm_slope, col = "slope"),
               alpha = .7, size = 1.3, pch = 16, stroke = 0) +
    geom_point(aes(H2O_ppm, CO2_dry_poly, col = "polynomial"),
               alpha = .7, size = 1.3, pch = 16, stroke = 0) +
    geom_smooth(method = "lm", formula = y ~ x, se = FALSE,
                mapping = aes(H2O_ppm, CO2_dry_ppm_slope, col = "slope")) +
    geom_smooth(method = "lm", formula = y ~ x, se = FALSE,
                mapping = aes(H2O_ppm, CO2_dry_poly, col = "polynomial")) +
    geom_smooth(method = "lm", formula = y ~ x, se = FALSE,
                mapping = aes(H2O_ppm, CO2_ppm, col = "none")) +
    theme_copernicus() +
    scale_y_continuous(expand = expansion(mult = c(.1,.1)))  + 
    labs(x = expression(paste(H[2],O, " [ppm]")),
         y = expression(paste(CO[2], " [ppm]")))  +
                theme(legend.position = "bottom",
                      legend.box = "horizontal",
                      legend.direction = "horizontal",
                      legend.margin = margin(1,1,1,1),
                      legend.box.margin = margin(1,1,1,1),
                      legend.title = element_text(size = 10, face = "bold",
                                                  margin = margin(0,5,0,0)),
                      legend.text= element_text(size = 10,
                                                margin = margin(0,7,0,0)),
                      legend.justification = c(1, 0),
                      legend.spacing.x = unit(1,'mm'),
                      legend.key.size = unit(4, "mm"),
                      legend.background = 
                          element_rect(fill = alpha("white", .8))) +
     scale_color_manual("Correction", values = mp(c(5,6,2))) + 
     no_grid()
#
print(water_correction_plot)

psave("water-correction.pdf", p = water_correction_plot, 
      height = 4.3, width = 4.3,
      output_dir = plot_output_dir)
