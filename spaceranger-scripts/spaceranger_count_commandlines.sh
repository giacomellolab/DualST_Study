#!/bin/sh

#command lines to run spaceranger count to generate count matrices from fastq files,
#and image files from each sample id

# Sample IDs given to run
# 1112417, 1112418, 1127394, 1127395, 1127396, 1135331, 1135332, 1135333, 1135334, 1180172, 1180173, 1180176, 1180177
# corresponding to P1CL B1, P1CL C1 , P2CL A1, P2CL B1, P2CL C1, P3CL A1, P3CL B1, P3CL C1, P3CL D1, P4nCL A1, P4nCL B1, P5nCL A1, P5nCL B1  

# Reference probe-set: Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv
# Custom probe set made by combining Sars-Cov-2 probes at the end of Visium human transcriptome probe set

spaceranger count \
    --fastqs=fastqs/1112417 \
    --lanes=1,2 \
    --image 7110.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10B13-401 \
    --area B1 \
    --id 1112417;

spaceranger count \
    --fastqs=fastqs/1112418 \
    --lanes=1,2 \
    --image 7111.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10B13-401 \
    --area C1 \
    --id 1112418;

spaceranger count \
    --fastqs=fastqs/1127394 \
    --lanes=1,2,3,4 \
    --image 8796.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10B13-400 \
    --area A1 \
    --id 1127394;

spaceranger count \
    --fastqs=fastqs/1127395 \
    --lanes=1,2,3,4 \
    --image 8797.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10B13-400 \
    --area B1 \
    --id 1127395;

spaceranger count \
    --fastqs=fastqs/1127396 \
    --lanes=1,2,3,4 \
    --image 8798.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10B13-400 \
    --area C1 \
    --id 1127396;

spaceranger count \
    --fastqs=fastqs/1135331 \
    --lanes=1,2,3,4 \
    --image 9737.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10L13-003 \
    --area A1 \
    --id 1135331;

spaceranger count \
    --fastqs=fastqs/1135332 \
    --lanes=1,2,3,4 \
    --image 9738.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10L13-003 \
    --area B1 \
    --id 1135332;

spaceranger count \
    --fastqs=fastqs/1135333 \
    --lanes=1,2,3,4 \
    --image 9739.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10L13-003 \
    --area C1 \
    --id 1135333;

spaceranger count \
    --fastqs=fastqs/1135334 \
    --lanes=1,2,3,4 \
    --image 9740.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10L13-003 \
    --area D1 \
    --id 1135334;

spaceranger count \
    --fastqs=fastqs/1180172 \
    --lanes=1,2,3,4 \
    --image 14381.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10S29-080 \
    --area A1 \
    --id 1180172;

spaceranger count \
    --fastqs=fastqs/1180173 \
    --lanes=1,2,3,4 \
    --image 14382.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10S29-080 \
    --area B1 \
    --id 1180173;

spaceranger count \
    --fastqs=fastqs/1180176 \
    --lanes=1,2,3,4 \
    --image 14385.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10S29-079 \
    --area A1 \
    --id 1180176;

spaceranger count \
    --fastqs=fastqs/1180177 \
    --lanes=1,2,3,4 \
    --image 14386.jpg \
    --transcriptome GRCh38_and_Sars-cov-2 \
    --probe-set Visium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A_and_covid.csv \
    --no-bam \
    --slide V10S29-079 \
    --area B1 \
    --id 1180177;