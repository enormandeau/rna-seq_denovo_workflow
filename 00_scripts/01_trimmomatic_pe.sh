#!/bin/bash
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

# Global variables

ADAPTERFILE="univec.fasta"
NCPU=8
TRIMMOMATIC_JAR="trimmomatic-0.36.jar"

for base in 02_data/*_R1.fastq.gz
do
    base=$(echo "${base%_R1.fastq.gz}")
    base=$(basename "$base")
    echo "$base"
    java -Xmx40G -jar $TRIMMOMATIC_JAR PE \
        -threads "$NCPU" \
        -phred33 \
            02_data/"$base"_R1.fastq.gz \
            02_data/"$base"_R2.fastq.gz \
            03_trimmed/"$base"_R1.paired.fastq.gz \
            03_trimmed/"$base"_R1.single.fastq.gz \
            03_trimmed/"$base"_R2.paired.fastq.gz \
            03_trimmed/"$base"_R2.single.fastq.gz \
            ILLUMINACLIP:"$ADAPTERFILE":2:20:7 \
            LEADING:20 \
            TRAILING:20 \
            SLIDINGWINDOW:30:30 \
            MINLEN:80 2> 98_log_files/log.trimmomatic.pe."$TIMESTAMP"
done

rm 03_trimmed/*single.fastq.gz
