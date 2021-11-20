source("scripts/0-theme.R")


high_freq_data <- readRDS('data/rds/high_freq_ec_30M.rds')

N <- high_freq_data[, .N]
high_freq_data[, is_updraft := w > 0]


# Apply the law of total expectation
dt_sum_up <- high_freq_data[, .(Ci_up = mean(C[is_updraft]*w[is_updraft]), 
                    time = first(time),
                    duration = last(time) - first(time),
                    P_up = sum(is_updraft)/N, 
                    w_abs_sum_up = sum(abs(w[is_updraft])), 
                    .N), by = J_up]

dt_sum_down <- high_freq_data[, .(Ci_down = mean(C[!is_updraft]*w[!is_updraft]),
                    P_down = sum(!is_updraft)/N, 
                    time = first(time),
                    duration = last(time) - first(time),
                    w_abs_sum_down = sum(abs(w[!is_updraft])), 
                    .N), by = J_down]


dt_sum_up[, massflow := w_abs_sum_up / as.numeric(duration)]
dt_sum_down[, massflow := w_abs_sum_down / as.numeric(duration)]

dt_sum <- 
    rbind(dt_sum_up[,.(time, duration, massflow, P = P_up, 
                       Ci = Ci_up, Z = "updraft")],
      dt_sum_down[,.(time, duration, massflow = massflow, P = P_down,
                     Ci = Ci_down, Z = "downdraft")])


# Coherence check 
high_freq_data[, cov(C,w)*(.N -1)/.N] # ==
sum(dt_sum[,Ci*P]) - high_freq_data[, mean(C)*mean(w)] #==
high_freq_data[, mean(C*w)] #==
dt_sum_up[, sum(Ci_up*P_up)] + 
        dt_sum_down[, sum(Ci_down*P_down)] - high_freq_data[,mean(C)*mean(w)]

# Range of accumulation interval length
dt_sum[, range(duration)]

stea_sampling <- 
    ggplot(high_freq_data) + 
         geom_rect(data = dt_sum, inherit.aes = FALSE,
                   aes(xmin = time, ymin = 0, fill = Z,
                       xmax = time + duration - 2, 
                       ymax = sign(Ci) * massflow*70),
                   alpha = .4,  col = "black", size = .1) +
        geom_line(data = dt_sum, inherit.aes = FALSE,
                  aes(x = time + duration/2, y = Ci, col = Z),
                  lty = 2, size = .4) +
        geom_point(data = dt_sum, inherit.aes = FALSE,
                  aes(x = time + duration/2, y = Ci, fill = Z),
                  col = 'gray30', shape= 22) +
        theme_copernicus()  + 
        no_grid() + 
        scale_fill_manual("Buffer volume", 
                          values = main_palette[c(1,2)]) +
        scale_color_manual("Buffer volume", 
                          values = main_palette[c(1,2)]) + 
        labs(x= "time", y = expression (paste(C[i], " [", mu,mol~mol^-1, "]")))
print(stea_sampling)

# Nice Plot
stea_raw_signal <- 
    ggplot(high_freq_data) + 
        geom_line(aes(time, C*w,
                      col = Z, group = NA), size = .3, alpha = .1) +
        geom_point(aes(time, C*w, col = Z), size = .3, alpha = .2) +
        theme_copernicus()  + 
        no_grid() + 
        coord_cartesian(ylim = c(-300, 300)) +
        scale_fill_manual("Buffer volume", 
                          values = main_palette[c(1,2)]) +
        scale_color_manual("Buffer volume", 
                          values = main_palette[c(1,2)]) + 
        labs(x= "time",
             y = expression (paste(w,c, " [", mu,mol~m,~s^-1, "]"))) +
        guides(colour = "none", fill = "none") 

how_STEA_works <- 
    stea_raw_signal/stea_sampling +
            plot_annotation(tag_levels = "a", tag_suffix = ")") +
            plot_layout(guides = "collect",
                        widths = c(1,1.25)) & 
                theme(legend.position = "bottom",
                      legend.box = "horizontal",
                      legend.direction = "horizontal",
                      legend.margin = margin(1,1,1,1),
                      legend.box.margin = margin(1,1,1,1),
                      legend.title = element_text(size = 10, face = "bold",
                                                  margin = margin(0,5,0,0)),
                      legend.text= element_text(size = 10, margin = margin(0,7,0,0)),
                      legend.justification = c(1, 0),
                      legend.spacing.x = unit(1,'mm'),
                      legend.key.size = unit(4, "mm"),
                      legend.background = element_rect(fill = alpha("white", .8)))

print(how_STEA_works)

psave("how-STEA-method-works.pdf",
      p = how_STEA_works,
      height = 6.8, width = 8.3,
      output_dir = plot_output_dir)

