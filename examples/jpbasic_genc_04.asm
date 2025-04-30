function f
  vars
    a integer
    b integer
  endvars

     ;;; = 'reada;'
     readi %1
     a = %1
     ;;; = 'ifa==10thena=4*0+3;f();endif'
     %2 = 10
     %3 = a == %2
     ifFalse %3 goto endif1
     ;;; = 'a=4*0+3;'
     %4 = 4
     %5 = 0
     %6 = %4 * %5
     %7 = 3
     %8 = %6 + %7
     a = %8
     ;;; = 'f();'
     call f
  label endif1 :
     ;;; = 'b=a+9;'
     %9 = 9
     %10 = a + %9
     b = %10
     ;;; = 'writeb+a*2;'
     %11 = 2
     %12 = a * %11
     %13 = b + %12
     writei %13
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction

function main
  vars
    a integer
  endvars

     ;;; = 'reada;'
     readi %1
     a = %1
     ;;; = 'ifa==3thenf();endif'
     %2 = 3
     %3 = a == %2
     ifFalse %3 goto endif1
     ;;; = 'f();'
     call f
  label endif1 :
     ;;; = 'write".\n";'
     writes ".\n"
     return
endfunction


