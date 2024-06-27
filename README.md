# NGS-data-analysis-of-Aeromonas-Hydrophila

Data must be contained in the data folder, and genomic data in the genomes folder.

The order of use after downloading the data using fastq-dump:
First, run qc_raw.sh.

The trimmer.sh file should be modified based on the results from fastqc.

Run trimmer.sh for ERR4911987 and ERR4912885.

Next, run qc_po_trimmingu and then multiqc.

For alignment, run alignment.sh with the files po_trimmerze/ERR4911987_unpaired_1.fastq.gz and po_trimmerze/ERR4911987_unpaired_2.fastq.gz. Then, do the same for ERR4912885.

After alignment, run dedups.sh for ERR4912885 and ERR4911987.

Next, run freebayes.sh with the files dedup_reads_ERR4911987.bam and dedup_reads_ERR4912885.bam.

Run strelka.sh with the files dedup_reads_ERR4911987.bam and dedup_reads_ERR4912885.bam. Strelka results are located in strelka_germline_analysis/results/ in a folder named accordingly/variants.

Run platypus.sh with the files dedup_reads_ERR4911987.bam and dedup_reads_ERR4912885.bam.

Next, manually create a genomic database for the organism Aeromonas hydrophila since it is not available in the default database.

After entering the SnpEff folder, execute the command (using Strelka results as an example):

java -jar snpEff.jar -c snpEff.config Aeromonas_hydrophila data/Aeromonas_hydrophila/filteredstrelka85.vcf > annotatedstrelka85.vcf
and filter the obtained file using:

bcftools view -i 'INFO/ANN[*] ~ "HIGH"' annotatedstrelka85.vcf > high_impact_85_strelka.vcf
Then, save the data for creating a Venn diagram:

bcftools query -f '%CHROM\t%POS\n' high_impact_85_strelka.vcf > snps_strelka85.txt
Additionally, three Python scripts are included:

srednie_pokrycie.py, used after alignment to check whether the average coverage is counted correctly using samtools
extract_names_of_genes.py, for extracting gene names from the VCF file after SnpEff
venn_diagram.py, used for visualizing SNPs with Venn diagram for SNPS with high impact
