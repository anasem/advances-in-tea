source("scripts/0-theme.R")


# Load data 
simulation_fluxes <- readRDS(file = "data/rds/simulation_results_1w.rds")

# Analytical values 
w_mean_vals <- seq(-2,2,.005)
w_sd_vals   <- c(.65)
dt          <- data.table(expand.grid(w_mean_vals, w_sd_vals))

setnames(dt, c('w', 'sd'))
dt[,flux_error := flux_error_ratio(w, sd)]
dt[, w_sd_r := w/sd]
dt[,alpha := alpha_analytic(w, sd)]


Error0.1limit <- abs(dt[which.min(abs(flux_error - 0.1)), w_sd_r])
Error0.5limit <- abs(dt[which.min(abs(flux_error - 0.5)), w_sd_r])

# 0.1 Error, w/sw = 
Error0.1_text <- paste0('', TeX("0.1 Error, $\\bar{w}/ \\sigma_{w}$= \\pm", 
                               Error0.1limit))

fit_dt <- data.table(w_mean = seq(-5,5, 0.01), w_sigma = 1)


daytime    <- simulation_fluxes[, hour(time) > 7 & hour(time) < 18]
rho_filter <- simulation_fluxes[, abs(r_Tsw) > 0.25]

quality_filter  <- simulation_fluxes[, abs(RNcov) < 0.3 & 
                                     abs(Ts_alpha) < 0.7 & abs(r_Tsw) > 0.25]
C_Ts_model <- lm(C_alpha ~ Ts_alpha,
                 data = simulation_fluxes[quality_filter])

simulation_fluxes[, C_alpha_predicted := 
           predict(C_Ts_model, newdata = simulation_fluxes)]

simulation_fluxes[, C_alpha_res := 
           C_alpha_predicted - C_alpha]

simulation_fluxes[,flag := "OK"]
simulation_fluxes[!daytime, flag := "night-time"]
  
flux_error_ratio_analytical_and_observed <- 
    ggplot(simulation_fluxes[quality_filter]) + 
    aes(x = w_mean/w_sigma, 
        y = C_alpha*(w_mean/w_abs_mean), 
        col = cut_zL3(zL), shape = flag) + 
    geom_point(alpha = .7) +
    geom_line(data = fit_dt, inherit.aes = FALSE,
              aes(x = w_mean/w_sigma, y = flux_error_ratio(w_mean, w_sigma)), 
                  col = main_palette[[5]], size = 1, alpha = .5) +
    ylim(c(-0.1,1.1))  +
    xlim(c(-2.0,2.0)) + 
    geom_segment(aes(x = Error0.1limit, y = 0, 
                     xend = Error0.1limit, yend = 0.1), lty = 2, size = .2, 
                 inherit.aes = FALSE) +
    geom_segment(aes(x = -2.0, y = .5,
                     xend = -Error0.5limit, yend = 0.5), lty = 2, size = .2,
                 inherit.aes = FALSE) +
    geom_segment(aes(x = -Error0.1limit, y = 0,
                     xend = -Error0.1limit, yend = 0.1), lty = 2, size = .2,
                 inherit.aes = FALSE) +
    geom_segment(aes(x = -1.8, y = 0.1,
                     xend = -Error0.1limit, yend = 0.1), lty = 2, size = .2, 
                 inherit.aes = FALSE) + 
    geom_text(aes(x = -1.6, y = 0.13,
                  label = "bar(w)==0.32~sigma[w]"),
                  parse = TRUE, size = 3, check_overlap = TRUE, col = "black") +
    geom_text(aes(x = -1.6, y = 0.53, label = "bar(w)==0.87~sigma[w]"),
                  parse = TRUE, size = 3, check_overlap = TRUE, col = "black") +
    labs(x = TeX("$\\bar{w}/ \\sigma_{w}$"), y = TeX("CO_2 Flux error ratio")) +
    theme_copernicus() +
    stability_color_scale() +
    no_grid() +
    scale_shape_manual(name = "Time of the day", values = c(3, 15), 
                       labels = c("night", "day")) 
#
#

C_Ts_alpha_regression_plot <- 
    ggplot(simulation_fluxes[quality_filter])  + 
        aes(Ts_alpha, C_alpha, col = cut_zL3(zL), shape = flag) +
        geom_point(alpha = .7) +
        xlim(-.9,.9) +
        ylim(-1, 1) +
        no_grid () + 
        geom_abline(slope = 1, alpha = .3)+
        geom_model_equation(C_Ts_model, -.1, 0.95, size = 3, slope.digits = 3) +
        labs(y = expression(alpha[CO[2]]),
        x = expression(alpha[theta]))  + 
        stability_color_scale()  +
        theme_copernicus() +
        no_grid() +
        scale_shape_manual(name = "Time of the day", values = c(3, 15), 
                           labels = c("night", "day")) 

#
flux_error_and_alpha_regression <- 
    flux_error_ratio_analytical_and_observed + C_Ts_alpha_regression_plot +
        plot_annotation(tag_levels = "a", tag_suffix = ")") +
        plot_layout(guides = "collect",
                    widths = c(1.25,1)) & 
            theme(legend.position = "bottom",
                  legend.direction = "horizontal",
                  legend.box = "vertical",
                  legend.margin = margin(1,1,1,1),
                  legend.box.margin = margin(1,1,1,1),
                  legend.justification = "center",
                  legend.title = element_text(size = 11, face = "bold",
                                              margin = margin(0,5,0,0)),
                  legend.text= element_text(size = 10, margin = margin(0,7,0,0)),
                  legend.spacing.x = unit(1,'mm'),
                  legend.key.size = unit(4, "mm"),
                  legend.background = element_rect(fill = alpha("white", .8)))
print(flux_error_and_alpha_regression)

psave("flux-error-ratio-and-alpha-regression.pdf",
      p = flux_error_and_alpha_regression, 
      height = 4.7, width = 9,
      output_dir = plot_output_dir)
