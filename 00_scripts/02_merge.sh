#!/bin/bash
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

INPUTFOLDER="03_trimmed"
OUTPUTFOLDER="04_merged"

#cat all reads
gunzip -c "$INPUTFOLDER"/*_R1.paired.fastq.gz | pigz -c - > "$OUTPUTFOLDER"/all_reads.left.fastq.gz
gunzip -c "$INPUTFOLDER"/*_R2.paired.fastq.gz | pigz -c - > "$OUTPUTFOLDER"/all_reads.right.fastq.gz
