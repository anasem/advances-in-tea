source("scripts/0-theme.R")

# Load data 
simulation_fluxes <- readRDS(file = "data/rds/simulation_results_1w.rds")

# Define data quality filter
quality_filter  <- simulation_fluxes[, abs(RNcov) < 0.3 & abs(Ts_alpha) < 0.7]

# Ratio of values flagged with unsteady state conditions flag
simulation_fluxes[, sum(abs(RNcov) > 0.3)/.N] 
# Ratio of values flagged with high alpha values
simulation_fluxes[abs(RNcov) < 0.3][, sum(abs(Ts_alpha) > 0.7)]/simulation_fluxes[, .N]


flux_range <- 
    range(simulation_fluxes[quality_filter,
          c(ec_flux, tea_flux_turnipseed,
            tea_flux_emad, tea_flux_hicks)])

# Time range of simulation data
simulation_fluxes[,range(time)]

simulation_fluxes[, range(w_mean)]


method_color_scale <- 
    scale_color_manual("TEA method", 
                       values = c("ES21" = main_palette[3], 
                                  'T09' = main_palette[5], 
                                  "HM86" = main_palette [6]), 
                       labels = c("ES21" = 
                                  expression(current~study~using~alpha[theta]),
                              "T09" = "Turnipseed et al, 2009", 
                              "HM86" = "Hicks and McMillen, 1986"))  

method_fill_scale <- 
    scale_fill_manual("TEA method", 
                       values = c("ES21" = main_palette[3], 
                                  'T09' = main_palette[5], 
                                  "HM86" = main_palette [6]), 
                       labels = c("ES21" = 
                                  expression(current~study~using~alpha[theta]),
                              "T09" = "Turnipseed et al, 2009", 
                              "HM86" = "Hicks and McMillen, 1986")) 



#
nonzero_w_methods_regression <- 
  ggplot(simulation_fluxes[quality_filter,]) + 
      aes(x = ec_flux)  +
      geom_point(aes(y =tea_flux_hicks,
                     col= 'HM86'), alpha = .5, 
                 shape = 15)  +
      geom_point(aes(y =  tea_flux_turnipseed, col= 'T09'), 
                 shape = 15, alpha = .5) +
      geom_point(aes(y =  tea_flux_emad, col= 'ES21'), 
                 shape = 15, alpha = .5) +
      geom_abline(slope = 1, alpha = .2) +
      scale_color_discrete("Formula")  + 
      method_color_scale + 
      theme_copernicus() +
      no_grid() +
      scale_x_continuous(expand = c(0.01,0)) +
      scale_y_continuous(expand = c(0.01,0)) +
      xlim(flux_range[1],flux_range[2]) + 
      ylim(flux_range[1],flux_range[2]) +
      labs (x= expression (paste(EC~CO[2], " flux [", mu,mol~m^-2,~s^-1, "]")),
            y = expression (paste(TEA~CO[2],
                                  " flux [", mu,mol~m^-2,~s^-1, "]")))  +
      guides(colour = "none")


nonzero_w_methods_density <- 
    ggplot(simulation_fluxes) +  
        geom_density(aes((tea_flux_turnipseed - ec_flux)/ec_flux,
                         fill = "T09", col = "T09"), alpha = .3) +
        geom_density(aes((tea_flux_hicks - ec_flux)/ec_flux,
                         fill = "HM86", col = "HM86"), alpha =  .7) +
        geom_density(aes((tea_flux_emad - ec_flux)/ec_flux,
                         fill= "ES21", col = "ES21"), alpha =.4) +
        geom_vline(xintercept = 0, lty = 2) +
        labs(x = "Flux error ratio") +
        xlim(-.75,.75) + 
        method_fill_scale +
        method_color_scale  +
        theme_copernicus()  +
        no_grid() 

nonzero_w_methods_comparison <- 
    nonzero_w_methods_regression + 
        nonzero_w_methods_density +
        plot_annotation(tag_levels = "a", tag_suffix = ")") +
        plot_layout(guides = "collect",
                    widths = c(1,1.25)) & 
            theme(legend.position = "bottom",
                  legend.box = "horizontal",
                  legend.direction = "horizontal",
                  legend.margin = margin(1,1,1,1),
                  legend.box.margin = margin(1,1,1,1),
                  legend.title = element_text(size = 10, 
                                              face = "bold",
                                              margin = margin(0,5,0,0)),
                  legend.text= element_text(size = 10,
                                            margin = margin(0,7,0,0)),
                  legend.justification = c(1, 0),
                  legend.spacing.x = unit(1,'mm'),
                  legend.key.size = unit(4, "mm"),
                  legend.background = element_rect(fill = alpha("white", .8)))
#
print(nonzero_w_methods_comparison)

psave("TEA-different-equations-comparison.pdf", p = nonzero_w_methods_comparison, 
      height = 4.2, width = 8.3,
      output_dir = plot_output_dir)

