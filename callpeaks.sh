#!/bin/bash
macs2 callpeak -t ../../Bed/R22047893-ZYC220924-A549H3k9aCis90P1_GGAG.bed -c ../../Bed/R22048397-ZYC220927-A549H3k9aCis90I1_Final_center_sequence.bed -g hs -p 0.01 -n A549H3k9aCis90P1 --nomodel --extsize 300 -f BED -B --SPMR >> R22048397-ZYC220927-A549H3k9aCis90P1.log 2>&1

macs2 callpeak -t ../../Bed/R22047893-ZYC220924-A549H3k9aCis90P2_GGAG.bed -c ../../Bed/R22048397-ZYC220927-A549H3k9aCis90I2_Final_center_sequence.bed -g hs -p 0.01 -n A549H3k9aCis90P2 --nomodel --extsize 300 -f BED -B --SPMR >> R22048397-ZYC220927-A549H3k9aCis90P2.log 2>&1
