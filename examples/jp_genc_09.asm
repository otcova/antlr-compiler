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
     readi max
     ;;; = 'ifi<=maxthenend=false;elsei=0;endif'
     %3 = i <= max
     ifFalse %3 goto else2
     ;;; = 'end=false;'
     %4 = 0
     end = %4
     goto endif1
  label else2 :
     ;;; = 'i=0;'
     %5 = 0
     i = %5
  label endif1 :
     ;;; = 'whilenotenddowritei;write"!=";writefact(i);write"\n";ifi==maxthenend=true;elsei=i+1;endifendwhile'
  label while1 :
     %6 = not end
     ifFalse %6 goto endwhile1
     ;;; = 'writei;'
     writei i
     ;;; = 'write"!=";'
     writes "!="
     ;;; = 'writefact(i);'
     pushparam 
     pushparam i
     call fact
     popparam 
     popparam %7
     writei %7
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'ifi==maxthenend=true;elsei=i+1;endif'
     %8 = i == max
     ifFalse %8 goto else4
     ;;; = 'end=true;'
     %9 = 1
     end = %9
     goto endif3
  label else4 :
     ;;; = 'i=i+1;'
     %10 = 1
     %11 = i + %10
     i = %11
  label endif3 :
     goto while1
  label endwhile1 :
     return
endfunction


