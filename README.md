# NGS-data-analysis-of-Aeromonas-Hydrophila

## Description
This project focuses on the analysis of Next-Generation Sequencing (NGS) data for the bacterium Aeromonas hydrophila. The analysis pipeline includes quality control, trimming, alignment, deduplication, variant calling, annotation, and visualization. The primary objective is to identify and annotate high-impact SNPs (Single Nucleotide Polymorphisms) in the genomic data.

## Directory Structure
* data/: Contains raw sequencing data
* genomes/: Contains genomic data

## Workflow
### Step 1: Download Data
Use `fastq-dump` to download the raw sequencing data into the `data` folder.

### Step 2: Quality Control on Raw Data
Run the quality control script:
```bash
bash qc_raw.sh
```

### Step 3: Trimming
Modify the `trimmer.sh` script based on the results from `fastqc`. (Examples: ERR4911987,ERR4912885)  Then, run the script:
```bash
bash trimmer.sh ERR4911987
bash trimmer.sh ERR4912885
```

### Step 4: Post-trimming Quality Control
Run the post-trimming quality control and summarize the results:
```bash
bash qc_po_trimmingu.sh
bash multiqc.sh
```

Align the trimmed reads to the reference genome:
```bash
bash alignment.sh po_trimmerze/ERR4911987_unpaired_1.fastq.gz po_trimmerze/ERR4911987_unpaired_2.fastq.gz
bash alignment.sh po_trimmerze/ERR4912885_unpaired_1.fastq.gz po_trimmerze/ERR4912885_unpaired_2.fastq.gz
```

### Step 6: Deduplication
Remove duplicate reads from the aligned data:
```bash
bash dedups.sh ERR4911987
bash dedups.sh ERR4912885
```

### Step 7: Variant Calling
Run FreeBayes and Strelka for variant calling:
```bash
bash freebayes.sh dedup_reads_ERR4911987.bam dedup_reads_ERR4912885.bam
bash strelka.sh dedup_reads_ERR4911987.bam dedup_reads_ERR4912885.bam
```

### Step 8: Additional Variant Calling with Platypus
Run Platypus for additional variant calling:
```bash
bash platypus.sh dedup_reads_ERR4911987.bam dedup_reads_ERR4912885.bam
```

### Step 9: Genomic Database Creation
Check if a genomic database is available in the default database. If not create it manually in snpEff.jar.

### Step 10: Annotation with SnpEff
Annotate the variants using SnpEff:
```bash
cd snpEff
java -jar snpEff.jar -c snpEff.config Aeromonas_hydrophila data/Aeromonas_hydrophila/filteredstrelka85.vcf > annotatedstrelka85.vcf
```

### Step 11: Filtering High-Impact Variants
Filter the annotated VCF file for high-impact variants:
```bash
bcftools view -i 'INFO/ANN[*] ~ "HIGH"' annotatedstrelka85.vcf > high_impact_85_strelka.vcf
```

### Step 12: Save Data for Venn Diagram
Extract SNP positions for creating a Venn diagram:
```bash
bcftools query -f '%CHROM\t%POS\n' high_impact_85_strelka.vcf > snps_strelka85.txt
```


