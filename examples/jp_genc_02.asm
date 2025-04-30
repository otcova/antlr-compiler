function main
  vars
    n integer
    f integer
    aux integer
    end boolean
  endvars

     ;;; = 'readn;'
     readi n
     ;;; = 'aux=n;'
     aux = n
     ;;; = 'ifn<0thenwrite"n >= 0!\n";end=true;endif'
     %1 = 0
     %2 = n < %1
     ifFalse %2 goto endif1
     ;;; = 'write"n >= 0!\n";'
     writes "n >= 0!\n"
     ;;; = 'end=true;'
     %3 = 1
     end = %3
  label endif1 :
     ;;; = 'f=1;'
     %4 = 1
     f = %4
     ;;; = 'whilenotendandn>1dof=f*n;n=n-1;endwhile'
  label while1 :
     %5 = not end
     %6 = 1
     %7 = n <= %6
     %7 = not %7
     %8 = %5 and %7
     ifFalse %8 goto endwhile1
     ;;; = 'f=f*n;'
     %9 = f * n
     f = %9
     ;;; = 'n=n-1;'
     %10 = 1
     %11 = n - %10
     n = %11
     goto while1
  label endwhile1 :
     ;;; = 'ifend==falsethenwriteaux;write"!=";writef;write"\n";endif'
     %12 = 0
     %13 = end == %12
     ifFalse %13 goto endif2
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


