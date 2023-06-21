#!/bin/bash
for i in *.ASC
do
if [ -e "$i" ]
then
	nome=${i%%.*}
	nome_asc="${nome}.are"
	nome_root="${nome}.root"
	secondi=`head -n1 ${i} | cut -d " " -f 16`
	carattere=${secondi:0:1}
	while [ $carattere -eq 0 ]
	do
		secondi=${secondi:1}
		carattere=${secondi:0:1}
	done
	secondi="${secondi}.0"
	echo "$nome $nome_asc $nome_root $secondi"
	echo "Sto processando il file $i..."
	root -b -q $HOME/bin/asctoroot.C\(\"$nome_asc\",\"$nome_root\",\"$nome\",$secondi\)
	echo "fatto!"
fi
done
