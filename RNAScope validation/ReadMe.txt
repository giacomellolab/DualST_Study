This is a set of codes for running the RNAScope validation pipeline. All scripts are coded in Matlab 2021b. Its validity has been verified and guaranteed only if the program are run on Matlab 2021b or newer versions. If you come to any problems or bugs of the program, please contact Jian Wu. (email: jian.wu@scilifelab.se)


This codes contains three parts, as is stated in the supplementary:
1. RNAScope signal processing (RNAScopeCall);
2. ST signal processing (STCall);
3. Validation analysis.

The codes of the three parts are respectively contained in three folders, the names of which clearly indicates their functions.

Before he/she run any program, one needs to download the image data from xxx.
There are two folders of image data as follows
1. RNAScopeCall/ImageOriginal
2. STCall/ImageOriginal
One needs to place those folders as is indicated above.

If he/she has downloaded and placed the data folders properly, one can begin run the program following the instructions as follows.

In the first two folders, i.e. RNAScope and ST signal processing, please just run the scripts named as RunMeFirst.m, then the results of the pipeline will automatically come out. The final result of each pipeline is a set of pseudo-image data, with which the validation analysis can be performed.

Only if both the first two parts have been successfully run, then one can run the third part of validation analysis. Otherwise, one must come to errors of unknown kinds. Please run the scripts in the folder in the order as follows:
1. DataConfMatRNA.m
2. FigureCurve.m
