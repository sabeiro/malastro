for i in *md;
do
	outF=../${i/md/html}
	titN=${i/.md/}
	echo $outF
	cat header.html | sed 's/title_name/'"$titN"'/' > $outF
#:	markdown $i >> $outF
#       md2html $i >> $outF
#	markdown_py $i >> $outF
#	python3 -m markdown $i >> $outF
#        pandoc -f markdown --filter pandoc-citeproc $i >> $outF
        pandoc -f markdown+pipe_tables $i >> $outF
	echo -e  '</body></html>' >> $outF
done

