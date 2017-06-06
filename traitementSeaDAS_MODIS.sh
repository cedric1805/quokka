#!/bin/bash
export PATH=/Applications/seadas-7.3/bin:$PATH
export OCSSWROOT=/Applications/seadas-7.3.2/ocssw
source $OCSSWROOT/OCSSW_bash.env
## =================================================
## =================================================

## Step 1 : L1A to GEO
## =================================================
modis_geo.py	/Users/cmenut/Desktop/V3/0-donnees_brutes/1-MODIS_L1A_LAC/A2013283040500.L1A_LAC	-o	/Users/cmenut/Desktop/V3/0-donnees_brutes/1-MODIS_L1A_LAC/A2013283040500.GEO

## Step 2 : L1A + GEO to L1B
## =================================================
cd	/Users/cmenut/Desktop/V3/0-donnees_brutes/1-MODIS_L1A_LAC/
modis_L1B.py	A2013283040500.L1A_LAC

## STEP 3 : L1B_LAC + GEO to L2LAC
## =================================================
l2gen	ifile=A2013283040500.L1B_LAC	geofile=A2013283040500.GEO	ofile1=/Users/cmenut/Desktop/V3/1-donnees_traitees/1-MODIS_L2_LAC/A2013283040500.L2_LAC_OC	l2prod="Rrs_vvv a_vvv_qaa b_vvv_qaa bb_vvv_qaa bbp_vvv_qaa chlor_a"
exit 0
