#!/bin/bash

#Qui voglio scrivere i comandi che mi son sempre costati un sacco
#          di fatica per sistemarli.
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#cambiare la data o creare i file ciccia
find . -iname 'ciccia*' -exec touch '{}'\;
#oppure
find . -iname 'ciccia*' | xargs touch
#cancellare i file pi`u vecchi di quello iniziale 
#        (che verr`a cancellato anch'esso)
find . -iname 'output*' -not -newer output000000000.dat -exec rm '{}' \; 
#oppure 
for i in *dat;
do 
	if [ $i -ot output0000000000.dat ]
		rm $i;
	fi
done;
