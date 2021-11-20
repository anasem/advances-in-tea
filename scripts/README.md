### Requirements

The following R packages are required

- ggplot2
- data.table
- lmodel2
- lubridate
- latex2exp
- patchwork
- pracma
    
Input data files should be put in `../data/rds`. Each script file produces one
figure as per the prefixed number. 
The file `0-theme.R` is sourced at the begining of
each script.


### R session info

    
```r
> sessionInfo()
R version 4.1.1 (2021-08-10)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Manjaro Linux

Matrix products: default
BLAS/LAPACK: /opt/intel/mkl/lib/intel64/libmkl_gf_lp64.so

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=de_DE.UTF-8       
 [4] LC_COLLATE=en_US.UTF-8     LC_MONETARY=de_DE.UTF-8    LC_MESSAGES=en_US.UTF-8   
 [7] LC_PAPER=de_DE.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
[10] LC_TELEPHONE=C             LC_MEASUREMENT=de_DE.UTF-8 LC_IDENTIFICATION=C       

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] pracma_2.3.3      patchwork_1.1.1   latex2exp_0.5.0   lubridate_1.7.10  lmodel2_1.7-3    
[6] ggplot2_3.3.5     data.table_1.14.0 nvimcom_0.9-122   colorout_1.2-2   

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.7       magrittr_2.0.1   tidyselect_1.1.1 munsell_0.5.0    colorspace_2.0-2
 [6] R6_2.5.0         rlang_0.4.11     fansi_0.5.0      stringr_1.4.0    dplyr_1.0.7     
[11] tools_4.1.1      grid_4.1.1       gtable_0.3.0     utf8_1.2.1       DBI_1.1.1       
[16] withr_2.4.2      ellipsis_0.3.2   assertthat_0.2.1 tibble_3.1.2     lifecycle_1.0.0 
[21] crayon_1.4.1     farver_2.1.0     purrr_0.3.4      vctrs_0.3.8      glue_1.4.2      
[26] stringi_1.6.2    compiler_4.1.1   pillar_1.6.1     generics_0.1.0   scales_1.1.1  
```
