function fact
  params
    _result integer
    n integer
  endparams

  vars
    f integer
  endvars

     ;;; = 'f=1;'
     %1 = 1
     f = %1
     ;;; = 'whilen>1dof=f*n;n=n-1;endwhile'
  label while1 :
     %2 = 1
     %3 = n <= %2
     %3 = not %3
     ifFalse %3 goto endwhile1
     ;;; = 'f=f*n;'
     %4 = f * n
     f = %4
     ;;; = 'n=n-1;'
     %5 = 1
     %6 = n - %5
     n = %6
     goto while1
  label endwhile1 :
     ;;; = 'returnf;'
     _result = f
     return
     return
endfunction

function main
  vars
    max integer
    i integer
    f integer
    end boolean
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'end=true;'
     %2 = 1
     end = %2
     ;;; = 'readmax;'
     readi %3
     max = %3
     ;;; = 'ifi<=maxthenend=false;elsei=0;endif'
     %4 = i <= max
     ifFalse %4 goto else2
     ;;; = 'end=false;'
     %5 = 0
     end = %5
     goto endif1
  label else2 :
     ;;; = 'i=0;'
     %6 = 0
     i = %6
  label endif1 :
     ;;; = 'whilenotenddowritei;write"!=";writefact(i);write"\n";ifi==maxthenend=true;elsei=i+1;endifendwhile'
  label while1 :
     %7 = not end
     ifFalse %7 goto endwhile1
     ;;; = 'writei;'
     writei i
     ;;; = 'write"!=";'
     writes "!="
     ;;; = 'writefact(i);'
     pushparam 
     pushparam i
     call fact
     popparam 
     popparam %8
     writei %8
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'ifi==maxthenend=true;elsei=i+1;endif'
     %9 = i == max
     ifFalse %9 goto else4
     ;;; = 'end=true;'
     %10 = 1
     end = %10
     goto endif3
  label else4 :
     ;;; = 'i=i+1;'
     %11 = 1
     %12 = i + %11
     i = %12
  label endif3 :
     goto while1
  label endwhile1 :
     return
endfunction


