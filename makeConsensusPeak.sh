#!/bin/bash

ls /cluster/home/lilin/Project/DNA_Damage/Cor/Cis_chip/Diff/*narrowPeak| \
while read id
do
	awk '{if($9>=2){print $0}}' $id | sort -k1,1 -k2,2n > ${id%.narrowPeak}.q2.Peak.tmp
done


# merge peak
echo "$(date "+%Y-%m-%d %H:%M:%S")  Merge peaks and de-balcklist."
echo " "

bedtools multiinter -i *Peak.tmp > multiinter.peak.tmp
bedtools merge -i multiinter.peak.tmp > consensus.peak.tmp
bedtools intersect -a consensus.peak.tmp  -b /cluster/home/lilin/Data/Hg38/hg38.blacklist.bed -wa -v > consensus.peak.filterbyBlack.bed.tmp
awk '{print $1"\t"$2"\t"$3}' consensus.peak.filterbyBlack.bed.tmp >consensus.deBlack.peak

# delete all temp files
rm *tmp


# computes coverage
echo "$(date "+%Y-%m-%d %H:%M:%S")  Compute coverage."
echo " "

for sm in R22047893-ZYC220924-A549H3k9aCis90P1_GGAG R22047893-ZYC220924-A549H3k9aCis90P2_GGAG R22048397-ZYC220927-A549H3k9aCis90C1.Final_sort R22048397-ZYC220927-A549H3k9aCis90C2.Final_sort R22035885-ZYC220812-A549Cisplatin100ngD_GGAG R22035885-ZYC220812-A549Cisplatin50ngD_GGAG

do 
	bedtools coverage -a /cluster/home/lilin/Project/DNA_Damage/Cor/Cis_chip/Diff/consensus.deBlack.peak -b /cluster/home/lilin/Project/DNA_Damage/Cor/Cis_chip/Bed/${sm}.bed > ${sm}.cov.tmp
done

# merge coverage
echo "$(date "+%Y-%m-%d %H:%M:%S")  Merge coverage and make peak-based expression matrix."
echo " "

python mergeCov.py
gzip consensus.deBlack.peak.mtx
# delete all temp files
#rm *tmp

echo "$(date "+%Y-%m-%d %H:%M:%S")  Done."
echo " "

