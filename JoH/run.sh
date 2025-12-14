#!/bin/bash

################################################################################
## the following run type 1, type 2, type 3, and type 4 instances
## KMIS_E_CARD 1-3: VNS for type1, type2, type3
## KMIS_E_CARD 4-6: GRASP for type1, type2, type3
## KMIS_E_CARD 7: VNS for type4
## KMIS_E_CARD 8: GRASP for type4
################################################################################

rm expKMIS-* ;

# Compile all versions
make KMIS_E_CARD=1 ;
make KMIS_E_CARD=2 ;
make KMIS_E_CARD=3 ;
make KMIS_E_CARD=4 ;
make KMIS_E_CARD=5 ;
make KMIS_E_CARD=6 ;
make KMIS_E_CARD=7 ;
make KMIS_E_CARD=8 ;

sleep 3 ;

# Run VNS for all types (1, 2, 3, 4)
./expKMIS-1 &
./expKMIS-2 &
./expKMIS-3 &
./expKMIS-7 &

# Uncomment below to also run GRASP
# ./expKMIS-4 &
# ./expKMIS-5 &
# ./expKMIS-6 &
# ./expKMIS-8 &