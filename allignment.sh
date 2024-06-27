#!/bin/bash
output_dir="po_bwa"
reference="genomes/genome.fna"
threads=4

mkdir -p "$output_dir"

read1="$1"
read2="$2"


filename=$(basename -- "$read1")
sample_id="${filename%%_*}"  
filename_no_ext="${sample_id}_aligned" 

sam_output="$output_dir/${filename_no_ext}.sam"
bam_output="$output_dir/${filename_no_ext}.bam"
sorted_bam_output="$output_dir/${filename_no_ext}_sorted.bam"

if [ ! -e "${reference}.bwt" ]; then
    bwa index "$reference"
fi

bwa mem -t "$threads" "$reference" "$read1" "$read2" > "$sam_output"
samtools view -@ "$threads" -Sb "$sam_output" > "$bam_output"
samtools sort -@ "$threads" "$bam_output" -o "$sorted_bam_output"
samtools index "$sorted_bam_output"
