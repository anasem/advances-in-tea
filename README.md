This repository contains data and scripts needed to reproduce the figures of the
paper

## Advances in the True Eddy Accumulation method: New theory, implementation, and field results

Currently under review in AMT  
 [![DOI:10.5194/amt-2021-319](https://img.shields.io/badge/doi-10.5194%2Famt--2021--319-blue)](https://doi.org/10.5194/amt-2021-319)

Data and code are also available at
- Data (RDS and CSV) [![DOI:10.25625/IVTS87](https://img.shields.io/badge/doi-10.25625%2FIVTS87-blue)](https://doi.org/10.25625/IVTS87)
 - Code [![DOI:10.25625/SYQITK](https://img.shields.io/badge/doi-10.25625%2FSYQITK-blue)](https://doi.org/10.25625/SYQITK)
 
 
 
 
## Data format
Data are provided under the directory `data` in two different formats:
- `rds`: native R serialization format, convenient and recommended for loading the data
  into R.
- `csv`: for intolerability, a copy of the data is provided in csv format.
 
### Metadata
Metadata for all files is stored under `data/metadata`.
The metadata contains information about variables description, units, and
instruments.

## Requirements

The font [Carrois Gothic](https://fonts.google.com/specimen/Carrois+Gothic) is
required for the figures.

### R session info
<details>
   <summary>sessionInfo()</summary>
 
   ```R
   > sessionInfo()
   R version 4.1.1 (2021-08-10)
   Platform: x86_64-pc-linux-gnu (64-bit)
   Running under: Manjaro Linux

   Matrix products: default
   BLAS:   /usr/lib/libopenblasp-r0.3.17.so
   LAPACK: /usr/lib/liblapack.so.3.10.0

   locale:
    [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C               LC_TIME=de_DE.UTF-8       
    [4] LC_COLLATE=en_GB.UTF-8     LC_MONETARY=de_DE.UTF-8    LC_MESSAGES=en_GB.UTF-8   
    [7] LC_PAPER=de_DE.UTF-8       LC_NAME=C                  LC_ADDRESS=C              
   [10] LC_TELEPHONE=C             LC_MEASUREMENT=de_DE.UTF-8 LC_IDENTIFICATION=C       

   attached base packages:
   [1] stats     graphics  grDevices utils     datasets  methods   base     

   other attached packages:
   [1] pracma_2.3.3      patchwork_1.1.1   latex2exp_0.5.0   lubridate_1.7.10  lmodel2_1.7-3    
   [6] data.table_1.14.0 ggplot2_3.3.5     nvimcom_0.9-122   colorout_1.2-2   

   loaded via a namespace (and not attached):
    [1] Rcpp_1.0.7       pillar_1.6.1     compiler_4.1.1   tools_4.1.1      digest_0.6.27   
    [6] lifecycle_1.0.0  tibble_3.1.3     gtable_0.3.0     pkgconfig_2.0.3  rlang_0.4.11    
   [11] DBI_1.1.1        withr_2.4.2      dplyr_1.0.7      stringr_1.4.0    generics_0.1.0  
   [16] vctrs_0.3.8      grid_4.1.1       tidyselect_1.1.1 glue_1.4.2       R6_2.5.0        
   [21] fansi_0.5.0      purrr_0.3.4      farver_2.1.0     magrittr_2.0.1   scales_1.1.1    
   [26] ellipsis_0.3.2   assertthat_0.2.1 colorspace_2.0-2 labeling_0.4.2   utf8_1.2.2      
   [31] stringi_1.7.3    munsell_0.5.0    crayon_1.4.1    
 ```
 
</details>

