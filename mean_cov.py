coverage_file = "/Users/a123456/Downloads/coverageERR4912885.txt"

total_bases = 0
covered_bases = 0

with open(coverage_file, 'r') as f:
    for line in f:
        chrom, pos, depth = line.strip().split('\t')
        total_bases += 1
        covered_bases += int(depth)

average_coverage = covered_bases / total_bases if total_bases > 0 else 0
print(f"total_bases:  {total_bases}")
print(f"covered_bases:  {covered_bases}")
print(f"Average coverage: {average_coverage}")


