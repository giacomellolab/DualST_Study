#!/bin/sh

#command lines to create spaceranger reference for count matrices generation

cat GRCh38-2020-A/fasta/genome.fa Sars_cov_2.ASM985889v3/Sars_cov_2.ASM985889v3.dna.toplevel.fa > genome.fa
grep -v "#" GRCh38-2020-A/genes/genes.gtf > genes.gtf
grep -v "#" Sars_cov_2.ASM985889v3/Sars_cov_2.ASM985889v3.101.gtf  >> genes.gtf

spaceranger mkref \
--genome=GRCh38_and_Sars-cov-2 \
--fasta=genome.fa \
--genes=genes.gtf \
--nthreads=90 \
--memgb=32