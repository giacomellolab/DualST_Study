clear
close all

load data/result.mat

[SEN_rna,SPC_rna] = confusion_matrix(boolean(rna.S_align),boolean(spatial.S));

figure
confusionchart(boolean(rna.S_align),boolean(spatial.S));
