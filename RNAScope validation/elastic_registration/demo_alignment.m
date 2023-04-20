clear
close all

addpath(genpath('toolbox'))

%% generate spatial data
spatial=Visium2Object('data/spatial');

seurat=readtable('data/spatial/UMI_covid_genes.csv');
seurat = renamevars(seurat,'Var1','barcode');
colname = seurat.Properties.VariableNames(2:end);

spatial = AddFeature2Object(spatial,seurat);

spatial=MergeSpot(spatial,colname,3);

spatial.bw=boolean(imread('data/spatial/bw_tissue_lowres_image.png'));

spatial = CreatImageMesh(spatial,.5);

%% generate rnascope data
data=readtable('data/rna/signal_positions_list_ZCL01S');

colname = data.Properties.VariableNames(1:2);
data = mergevars(data,colname,'NewVariableName','position');
data = renamevars(data,'Var3','S');

rna.image=imread('data/rna/tissue_hires_image.png');
rna.scale=.05;

index_rna=find(data.S<quantile(data.S,.99));

rna.S=(data.S(index_rna)/80);
rna.position=data.position(index_rna,:);
rna.barcode=ones(size(rna.S));

rna.bw=imread('data/rna/bw_tissue_hires_image.png');
rna.scale=rna.scale*.25;
rna.image=imresize(rna.image,.25);
rna.bw=imresize(rna.bw,.25);

rna = CreatImageMesh(rna,.5);

%% generate iss data
data=readtable('data/iss/Pos-1_big_dots_position_list.txt');

colname = data.Properties.VariableNames(1:2);
data = mergevars(data,colname,'NewVariableName','position');
data = renamevars(data,'Var3','gene');

iss.image=imread('data/iss/Pos-1_big_dots.png');

iss.scale=.05;
iss.image=imresize(iss.image,iss.scale);

iss.S=data.gene==1;
iss.E=data.gene==2;
iss.position=data.position(:,[2 1]);
iss.barcode=ones(size(iss.S));

iss.bw=boolean(imread('data/iss/bw_Pos-1_big_dots.png'));
iss.bw=imresize(iss.bw,iss.scale);

iss = CreatImageMesh(iss,.75);

%% elastic aligment

spatial=prepare_alignment(spatial);

rna=prepare_alignment(rna);

iss=prepare_alignment(iss);

[rna,spatial] = elastic_alignment(rna,spatial);

[iss,spatial] = elastic_alignment(iss,spatial);

save data/result.mat spatial rna iss

close all

%% display results
figure
FeaturePlotMesh(spatial,'position','S',80,1);

rna.mesh.index=rna.mesh.index_align;
rna.S=rna.S_align;

figure
FeaturePlotMesh(rna,'position_align','S',80,1);

iss.mesh.index=iss.mesh.index_align;
iss.S=iss.S_align;

figure
FeaturePlotMesh(iss,'position_align','S',80,1);