#!/bin/bash
for i in R22047893-ZYC220924-A549H3k9aCis90P1 \
R22047893-ZYC220924-A549H3k9aCis90P2

do
	#samtools sort -@ 15 -o ${i}.bam ${i}.sort.bam
	#samtools index ${i}.sorted.bam
	#sambamba markdup -t 15 ${i}.sort.bam ${i}.markdup.bam
	sambamba view -h -t 4 -f bam -F 'not (duplicate) and proper_pair and not (unmapped or mate_is_unmapped) and not (secondary_alignment) and mapping_quality >= 25' ${i}.markdup.bam > ${i}.Final.tmp.bam
	samtools view -h ${i}.Final.tmp.bam | grep -v "chrM\|^chr[0-9Un]+_\|chrX_" > ${i}.Final.bam
	samtools sort -@ 3 -o ${i}.Final.sorted.bam ${i}.Final.bam
	samtools index ${i}.Final.sorted.bam
done
