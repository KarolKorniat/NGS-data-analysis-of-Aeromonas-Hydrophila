#!/bin/bash
sample=$1

mkdir -p marking_dups

samtools flagstat po_bwa/${sample}_aligned_sorted.bam
samtools depth po_bwa/${sample}_aligned_sorted.bam > coverage${sample}.txt

java -jar picard.jar MarkDuplicates I=po_bwa/${sample}_aligned_sorted.bam REMOVE_DUPLICATES=true O=marking_dups/dedup_reads_${sample}.bam M=marking_dups/metrics${sample}.txt
samtools index marking_dups/dedup_reads_${sample}.bam

qualimap bamqc -bam marking_dups/dedup_reads_${sample}.bam -outdir qualimap${sample}podup

bedtools genomecov -ibam marking_dups/dedup_reads_${sample}.bam -dz > coverage${sample}.txt

awk '{ total += $3; count++ } END { print total/count }' coverage${sample}.txt