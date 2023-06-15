# Dual spatially resolved transcriptomics for SARS-CoV-2 host-pathogen colocalization studies in humans
Hailey Sounart, Enikő Lazar, Yuvarani Masarapu, Jian Wu, Tibor Várkonyi, Tibor Glasz, András Kiss, Erik Borgström, Zsuzsanna Varga, Olaf Bergmann, Stefania Giacomello

## Data availability
The list of SARS-CoV-2 genes targeted by the probes in this study and used in the data analysis can be found in this [csv file](data/covid_genes.csv).
The sample IDs for corresponding count matrices can be accessed [here](data/sampleID-counts-foldermapping.txt).

The counts can be accessed here.
Corresponding sequences fastq files can be accessed upon request from here.
High-resolution tissue images can be downloaded from here.

## Code used of the data analysis
Scripts used for generating count matrices can be accessed under [spaceranger-scripts](spaceranger-scripts/) folder.

### Clustering analysis
All R scripts used to run the human genes clustering analysis can be found in sequential order ("<#>_filename.Rmd") under folder [R_scripts](R_scripts/).
This also includes the colocalization analysis of the SARS-CoV-2+ and SARS-CoV2- spots that was performed and mentioned in the manuscript. The metadata used in the [1_add_metadata.Rmd](R_scripts/1_add_metadata.Rmd) is within this [sheet](data/covidlung_metadata.xlsx). 

### Deconvolution analysis
Deconvolution was performed using Stereoscope. The input single cell data for the deconvolution was the [SCP1052](https://singlecell.broadinstitute.org/single_cell/study/SCP1052/covid-19-lung-autopsy-samples#study-download) dataset taken from the study 
[Delorey, T.M., Ziegler, C.G.K., Heimberg, G. et al. COVID-19 tissue atlases reveal SARS-CoV-2 pathology and cellular targets. Nature 595, 107–113 (2021). https://doi.org/10.1038/s41586-021-03570-8.](https://doi.org/10.1038/s41586-021-03570-8)

This dataset was subsampled to include donor ids: D1, D4, D5, D6, D8, D12, D18, D14, D16. These donor ids were selected based on the timeframe of symptom onset to death withon 13-20 days which is close to the duration of 13-17 days from diagnosis to death in our study.

Two Stereoscope runs were performed, one setting was tested for each run. These are stated below.

Setting 1: 5000 sc epochs and 10000 st epochs \
Setting 2: 15000 sc epochs and 25000 st epochs

The single cell data subsampling and preparation of the ST dataset for deconvolution was performed using scripts [prep_sc_data_deconv-CovidLung.Rmd](R_scripts/deconvolution/prep_sc_data_deconv-CovidLung.Rmd) and [prep_st_data_for_deconv-CovidLung.Rmd](R_scripts/deconvolution/prep_st_data_for_deconv-CovidLung.Rmd) respectively.
The results of the deconvolution were summarised in the script [summary_stereoscope_covid-lung.Rmd](R_scripts/deconvolution/summary_stereoscope_covid-lung.Rmd).

### Deconvolution-based colocalization analysis
More extensive analysis based on deconvolution to identify cluster-specific and cell-type-specific DE genes between the SARS-CoV-2+ and SARS-CoV2- spots was performed using the script [colocalisation_DE_deconvolution-based.Rmd](R_scripts/deconvolution-based_colocalization/colocalisation_DE_deconvolution-based.Rmd).

### Covid genes colocalization analysis
Analysis of the SARS-CoV-2+ spots to identify covid genes co-occurance with each other and their distribution can be re-run using the file [covid-genes_co-occurance.Rmd](R_scripts/covid-genes_colocalization/covid-genes_co-occurance.Rmd)

The Fisher's test and the Chi-square tests for the covid genes localization were performed using the script [covid_colcoalization_pvalues.Rmd](R_scipts/covid-genes_colocalization/covid_colcoalization_pvalues.Rmd) and the file [covid_gene_colocalization.csv](R_scripts/covid-genes_colocalization/covid_gene_colocalization.csv).

## Code for RNAScope validation
All the required scripts for running elastic registration, RNAscope and ST calls, validation analysis and running chi-square test on the confusion matrix are available in the folder RNAScope validation. 

There is a ReadMe.txt file in the same folder that describes what each script does in more details that are required for reproducibility.

The chi-square test on the confusion matrix was performed using the script [confusion_matrix_pvalue.Rmd](RNAScope validation/confusion_matrix_pvalue.Rmd).