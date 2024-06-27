#!/bin/bash
bam_file="$1"
mkdir -p variants

base_name=$(basename "$bam_file" .bam | sed 's/^dedup_reads_//')

freebayes -f genomes/genome.fna "marking_dups/$bam_file" > "variants/variantsfb${base_name}.vcf"
bcftools filter -e 'MQMR < 40 || FORMAT/DP < 10 || QUAL < 30' -o "variants/filtered_variantsfb${base_name}.vcf" "variants/variantsfb${base_name}.vcf"
