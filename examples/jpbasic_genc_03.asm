function f
  vars
    a integer
    b integer
  endvars

     ;;; = 'reada;'
     readi a
     ;;; = 'ifa==10thena=3;endif'
     %1 = 10
     %2 = a == %1
     ifFalse %2 goto endif1
     ;;; = 'a=3;'
     %3 = 3
     a = %3
  label endif1 :
     ;;; = 'b=a+67;'
     %4 = 67
     %5 = a + %4
     b = %5
     ;;; = 'writeb+a+1;'
     %6 = b + a
     %7 = 1
     %8 = %6 + %7
     writei %8
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


