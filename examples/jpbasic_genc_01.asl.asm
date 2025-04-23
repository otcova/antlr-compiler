function f1
  vars
    x1 integer
    y1 integer
  endvars

     ;;; = 'write"err!!\n";'
     writes "err!!\n"
     ;;; = 'ifx1==y1*2thenx1=y1+3;y1=x1+y1*x1;endif'
     %1 = 2
     %2 = y1 * %1
     %3 = x1 == %2
     ifFalse %3 goto endif1
     ;;; = 'x1=y1+3;'
     %4 = 3
     %5 = y1 + %4
     x1 = %5
     ;;; = 'y1=x1+y1*x1;'
     %6 = y1 * x1
     %7 = x1 + %6
     y1 = %7
  label endif1 :
     return
endfunction

function main
  vars
    x1 integer
  endvars

     ;;; = 'x1=0;'
     %1 = 0
     x1 = %1
     ;;; = 'ifx1==1thenf1();endif'
     %2 = 1
     %3 = x1 == %2
     ifFalse %3 goto endif1
     ;;; = 'f1();'
     call f1
  label endif1 :
     ;;; = 'x1=4*5+6;'
     %4 = 4
     %5 = 5
     %6 = %4 * %5
     %7 = 6
     %8 = %6 + %7
     x1 = %8
     ;;; = 'writex1;'
     writei x1
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


