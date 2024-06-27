#!/bin/bash
bam_file="$1"
mkdir -p variants
base_name=$(basename "$bam_file" .bam | sed 's/^dedup_reads_//')
platypus callVariants --bamFiles "marking_dups/$bam_file" --refFile genomes/genome.fna --output "variants/filtered_pepe${base_name}.vcf" --nCPU 4 --minMapQual 40 --minBaseQual 30 --minReads 4 --minVarFreq 0.1 --filterDuplicates 1

