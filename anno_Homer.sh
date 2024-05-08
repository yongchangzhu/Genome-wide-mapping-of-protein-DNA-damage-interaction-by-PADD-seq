#!/bin/bash
data=001_A549H3k9aCis90P_idr_sorted.bed
bed=$(basename $data .bed).bed
perl -ne 'print if $.>1' $data | cut -f1-3 > $bed
fullanno=$(basename $data .bed)_annofull.txt
anno=$(basename $data .bed)_annotated
head -1 $data | cut -f1-3 > h.txt

annotatePeaks.pl $bed /cluster/home/lilin/Software/Homer/data/genomes/hg38 > $fullanno
cut -f2-4,8,10,16,19 $fullanno | sed 's/ //g' | sed s/\(.*\)//g | sed 's/\.[0-9]  / /g' | sed 's/\... / /g' > ${anno}.tmp
head -1 ${anno}.tmp | sed 's/^Chr Start End/chr start end/g' > h.txt
perl -ne 'print if $.>1' ${anno}.tmp | sortBed | perl -lane 'print $F[0],"\t",$F[1]-1,"\t",$F[2],"\t",$F[3],"\t",$F[4],"\t",$F[5],"\t",$F[6]' | cat h.txt - > ${anno}.txt
rm *tmp
rm h.txt
