#!/bin/python

import sys
import numpy as np
import pandas as pd

#sample_path = sys.argv[1]
sample_path = '/cluster/home/lilin/Project/DNA_Damage/Cor/Cis_chip/Diff/sm.list'

samples = [line.strip() for line in open(sample_path)]
samples.sort()

peak = pd.read_table('consensus.deBlack.peak', sep='\t', header=None, names=['chr','start','end'])

for sm in samples:

	filename = sm + '.cov.tmp'

	sm_df = pd.read_table(filename, sep='\t', names=[sm], header=None, usecols=[3], dtype=int)

	peak[sm] = sm_df[sm]


peak.to_csv('consensus.deBlack.peak.mtx', sep='\t', header=True, index=False)

