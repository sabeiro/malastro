;;;
;;; rnu.lsp (C)2004 by Claudio Piccini
;;; 6 Aprile 2004
;;; http://www.cg-cad.com/
;;;
;;; distribuzione non uniforme
;;; di numeri casuali
;;;


(defun rn ()
 (setq m 65521 b 15937 c 33503 sd 
  (rem (+ (* b sd) c) m)
 )
 (/ sd m)
)

(defun distr_uniforme (n)
 (* (rn) n)  
)

(defun dist_non_uniforme ( n / i somma )
 (setq i 0)
 (setq somma 0)
 (while (< i 10)
  (setq somma (+ somma (distr_uniforme n)))
  (setq i (1+ i))
 )
 (setq somma (/ somma 10))
)

(defun c:rnu ( / sd f1 nomeDir nf n)
 (setq sd 0.0)
 (setq nomeDir (getvar "dwgprefix"))
 (setq nf (strcat nomeDir "ncnu.txt"))
 (setq f1 (open nf "w"))
 (initget (+ 1 2 4))
 (setq conta (getint "\nQuanti numeri? "))
 (initget (+ 1 2 4))
 (setq n (getint "\nIntervallo da 0 a? "))
 (repeat conta
  (setq sx (dist_non_uniforme n))
  ; salva la stringa sx (itoa sx) 
  ; nel file NCNU.TXT nella cartella attiva
  (write-line (itoa (fix sx)) f1)
  ;(setq sd sx)
 )
 (close f1)
)
;;;eof
