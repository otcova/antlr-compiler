function main
  vars
    n integer
    f integer
    aux integer
    end boolean
  endvars

     ;;; = 'readn;'
     readi %1
     n = %1
     ;;; = 'aux=n;'
     aux = n
     ;;; = 'ifn<0thenwrite"n >= 0!\n";end=true;endif'
     %2 = 0
     %3 = n < %2
     ifFalse %3 goto endif1
     ;;; = 'write"n >= 0!\n";'
     writes "n >= 0!\n"
     ;;; = 'end=true;'
     %4 = 1
     end = %4
  label endif1 :
     ;;; = 'f=1;'
     %5 = 1
     f = %5
     ;;; = 'whilenotendandn>1dof=f*n;n=n-1;endwhile'
  label while1 :
     %6 = not end
     %7 = 1
     %8 = n <= %7
     %8 = not %8
     %9 = %6 and %8
     ifFalse %9 goto endwhile1
     ;;; = 'f=f*n;'
     %10 = f * n
     f = %10
     ;;; = 'n=n-1;'
     %11 = 1
     %12 = n - %11
     n = %12
     goto while1
  label endwhile1 :
     ;;; = 'ifend==falsethenwriteaux;write"!=";writef;write"\n";endif'
     %13 = 0
     %14 = end == %13
     ifFalse %14 goto endif2
     ;;; = 'writeaux;'
     writei aux
     ;;; = 'write"!=";'
     writes "!="
     ;;; = 'writef;'
     writei f
     ;;; = 'write"\n";'
     writes "\n"
  label endif2 :
     return
endfunction


