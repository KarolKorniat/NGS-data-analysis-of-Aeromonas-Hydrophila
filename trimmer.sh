#!/bin/bash


sample_name=$1
mkdir -p po_trimmerze

read1=data/${sample_name}_1.fastq.gz
read2=data/${sample_name}_2.fastq.gz
OutputForwardPaired=po_trimmerze/${sample_name}_1.fastq.gz
OutputForwardUnpaired=po_trimmerze/${sample_name}_unpaired_1.fastq.gz
OutputReversePaired=po_trimmerze/${sample_name}_2.fastq.gz
OutputReverseUnpaired=po_trimmerze/${sample_name}_unpaired_2.fastq.gz
threads=4

bbduk.sh in1=$read1 in2=$read2 \
out1=$OutputForwardPaired out2=$OutputReversePaired \
outu1=$OutputForwardUnpaired outu2=$OutputReverseUnpaired \
qtrim=rl trimq=20 maq=20 minlen=60 \
ow=t forcetrimleft=10 \
threads=$threads
