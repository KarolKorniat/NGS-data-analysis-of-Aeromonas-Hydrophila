#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 <vcf_file1> [<vcf_file2> ...]"
    exit 1
fi


for vcf_file in "$@"; do
    echo "Processing file: $vcf_file"
    high_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "HIGH" | wc -l)
    low_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "LOW" | wc -l)
    modifier_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "MODIFIER" | wc -l)
    moderate_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "MODERATE" | wc -l)
    synonymous_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "SYNONYMOUS" | wc -l)
    non_synonymous_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "NON_SYNONYMOUS" | wc -l)
    stop_gained_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "STOP_GAINED" | wc -l)
    frame_shift_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "FRAME_SHIFT" | wc -l)
    splice_site_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "SPLICE_SITE" | wc -l)
    upstream_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "UPSTREAM" | wc -l)
    downstream_count=$(grep -v "^#" "$vcf_file" | awk -F'\t' '{print $8}' | grep -o "DOWNSTREAM" | wc -l)

    echo "Results for $vcf_file:"
    echo "HIGH: $high_count"
    echo "LOW: $low_count"
    echo "MODIFIER: $modifier_count"
    echo "MODERATE: $moderate_count"
    echo "SYNONYMOUS: $synonymous_count"
    echo "NON_SYNONYMOUS: $non_synonymous_count"
    echo "STOP_GAINED: $stop_gained_count"
    echo "FRAME_SHIFT: $frame_shift_count"
    echo "SPLICE_SITE: $splice_site_count"
    echo "UPSTREAM: $upstream_count"
    echo "DOWNSTREAM: $downstream_count"
    echo "-------------------------------------------------------"
done

exit 0
