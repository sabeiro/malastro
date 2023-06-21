#!/usr/bin/guile -s
 !#
 ;;;
 ;:;  guile test simple interface web
 ;;;  on /var/www/cgi-bin
 ;;;
 ;:;
 (display '"'Content-type: text/html\n\n'"')
 (display ''<html><head><title>lisp test tutor</title>\n'')
 (display "Ciccia\n")
 (display "</html>\n")
