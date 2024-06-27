#!/bin/bash

bam_file="$1"

base_name=$(basename "$bam_file" .bam | sed 's/^dedup_reads_//')

configureStrelkaGermlineWorkflow.py --bam "marking_dups/$bam_file" --referenceFasta genomes/genome.fna --runDir "strelka_germline_analysis/$base_name"
cd "strelka_germline_analysis/$base_name"
./runWorkflow.py -m local -j 8

