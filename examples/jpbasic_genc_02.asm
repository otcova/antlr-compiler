function f2
  vars
    x2 integer
    y2 integer
  endvars

     ;;; = 'x2=0;'
     %1 = 0
     x2 = %1
     ;;; = 'y2=x2;'
     y2 = x2
     ;;; = 'ifx2==y2*3thenx2=y2*5+3;y2=1+y2+1;ifx2+1==y2*2thenwrite"ok";endifify2==1+1thenwritex2*6;endifendif'
     %2 = 3
     %3 = y2 * %2
     %4 = x2 == %3
     ifFalse %4 goto endif3
     ;;; = 'x2=y2*5+3;'
     %5 = 5
     %6 = y2 * %5
     %7 = 3
     %8 = %6 + %7
     x2 = %8
     ;;; = 'y2=1+y2+1;'
     %9 = 1
     %10 = %9 + y2
     %11 = 1
     %12 = %10 + %11
     y2 = %12
     ;;; = 'ifx2+1==y2*2thenwrite"ok";endif'
     %13 = 1
     %14 = x2 + %13
     %15 = 2
     %16 = y2 * %15
     %17 = %14 == %16
     ifFalse %17 goto endif1
     ;;; = 'write"ok";'
     writes "ok"
  label endif1 :
     ;;; = 'ify2==1+1thenwritex2*6;endif'
     %18 = 1
     %19 = 1
     %20 = %18 + %19
     %21 = y2 == %20
     ifFalse %21 goto endif2
     ;;; = 'writex2*6;'
     %22 = 6
     %23 = x2 * %22
     writei %23
  label endif2 :
  label endif3 :
     return
endfunction

function main
     ;;; = 'if7==7thenf2();endif'
     %1 = 7
     %2 = 7
     %3 = %1 == %2
     ifFalse %3 goto endif1
     ;;; = 'f2();'
     call f2
  label endif1 :
     ;;; = 'write"bye\n";'
     writes "bye\n"
     return
endfunction


