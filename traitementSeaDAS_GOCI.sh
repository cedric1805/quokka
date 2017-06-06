#!/bin/bash
export PATH=/Applications/seadas-7.3/bin:$PATH
export OCSSWROOT=/Applications/seadas-7.3.2/ocssw
source $OCSSWROOT/OCSSW_bash.env
## =================================================
## =================================================
## declare an array variable input
declare -a arr_input=(/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901001644.he5	/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901011644.he5	/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901021642.he5	/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901031642.he5	/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901041642.he5	/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901051642.he5	/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901061642.he5	/Users/cmenut/Desktop/V3/0-donnees_brutes/0-GOCI_L1B/COMS_GOCI_L1B_GA_20150901071642.he5	)
## =================================================

## =================================================
## declare an array variable output
declare -a arr_output=(/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244001644.L2_LAC_OC	/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244011644.L2_LAC_OC	/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244021642.L2_LAC_OC	/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244031642.L2_LAC_OC	/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244041642.L2_LAC_OC	/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244051642.L2_LAC_OC	/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244061642.L2_LAC_OC	/Users/cmenut/Desktop/V3/1-donnees_traitees/_00_en_traitement/0-GOCI_L2_LAC/G2015244071642.L2_LAC_OC	)
## =================================================

## =================================================
n=${#arr_input}
echo n
for ((i=0;i<$n;i++)); do
	l2gen	ifile="${arr_input[i]}"	ofile1="${arr_output[i]}"	l2prod="taua_nnn"
done
exit 0
