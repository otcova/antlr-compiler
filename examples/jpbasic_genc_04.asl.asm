function f
  vars
    a integer
    b integer
  endvars

     ;;; = 'reada;'
     readi a
     ;;; = 'ifa==10thena=4*0+3;f();endif'
     %1 = 10
     %2 = a == %1
     ifFalse %2 goto endif1
     ;;; = 'a=4*0+3;'
     %3 = 4
     %4 = 0
     %5 = %3 * %4
     %6 = 3
     %7 = %5 + %6
     a = %7
     ;;; = 'f();'
     call f
  label endif1 :
     ;;; = 'b=a+9;'
     %8 = 9
     %9 = a + %8
     b = %9
     ;;; = 'writeb+a*2;'
     %10 = 2
     %11 = a * %10
     %12 = b + %11
     writei %12
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction

function main
  vars
    a integer
  endvars

     ;;; = 'reada;'
     readi a
     ;;; = 'ifa==3thenf();endif'
     %1 = 3
     %2 = a == %1
     ifFalse %2 goto endif1
     ;;; = 'f();'
     call f
  label endif1 :
     ;;; = 'write".\n";'
     writes ".\n"
     return
endfunction


