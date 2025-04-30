function f
  vars
    a integer
    b integer
  endvars

     ;;; = 'reada;'
     readi %1
     a = %1
     ;;; = 'ifa==10thena=3;endif'
     %2 = 10
     %3 = a == %2
     ifFalse %3 goto endif1
     ;;; = 'a=3;'
     %4 = 3
     a = %4
  label endif1 :
     ;;; = 'b=a+67;'
     %5 = 67
     %6 = a + %5
     b = %6
     ;;; = 'writeb+a+1;'
     %7 = b + a
     %8 = 1
     %9 = %7 + %8
     writei %9
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


