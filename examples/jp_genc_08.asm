function x2
  params
    _result integer
    a integer array
  endparams

  vars
    i integer
    n integer
  endvars

     ;;; = 'n=0;'
     %1 = 0
     n = %1
     ;;; = 'i=0;'
     %2 = 0
     i = %2
     ;;; = 'whilei<10doifa[i]<80thenn=n+1;endifa[i]=a[i]*2;writea[i];write"\n";i=i+1;endwhile'
  label while1 :
     %3 = 10
     %4 = i < %3
     ifFalse %4 goto endwhile1
     ;;; = 'ifa[i]<80thenn=n+1;endif'
     %5 = a
     %6 = %5[i]
     %7 = 80
     %8 = %6 < %7
     ifFalse %8 goto endif1
     ;;; = 'n=n+1;'
     %9 = 1
     %10 = n + %9
     n = %10
  label endif1 :
     ;;; = 'a[i]=a[i]*2;'
     %11 = a
     %12 = a
     %13 = %12[i]
     %14 = 2
     %15 = %13 * %14
     %11[i] = %15
     ;;; = 'writea[i];'
     %16 = a
     %17 = %16[i]
     writei %17
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %18 = 1
     %19 = i + %18
     i = %19
     goto while1
  label endwhile1 :
     ;;; = 'returnn;'
     _result = n
     return
     return
endfunction

function main
  vars
    x integer 10
    i integer
    z integer
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10dox[i]=77+i;i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'x[i]=77+i;'
     %4 = 77
     %5 = %4 + i
     x[i] = %5
     ;;; = 'i=i+1;'
     %6 = 1
     %7 = i + %6
     i = %7
     goto while1
  label endwhile1 :
     ;;; = 'i=0;'
     %8 = 0
     i = %8
     ;;; = 'whilei<10dowritex[i];write"\n";i=i+1;endwhile'
  label while2 :
     %9 = 10
     %10 = i < %9
     ifFalse %10 goto endwhile2
     ;;; = 'writex[i];'
     %11 = x[i]
     writei %11
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %12 = 1
     %13 = i + %12
     i = %13
     goto while2
  label endwhile2 :
     ;;; = 'z=x2(x);'
     pushparam 
     %14 = &x
     pushparam %14
     call x2
     popparam 
     popparam %15
     z = %15
     ;;; = 'write"z:";'
     writes "z:"
     ;;; = 'writez;'
     writei z
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=0;'
     %16 = 0
     i = %16
     ;;; = 'whilei<10dowrite"x[";writei;write"]=";writex[i];write"\n";i=i+1;endwhile'
  label while3 :
     %17 = 10
     %18 = i < %17
     ifFalse %18 goto endwhile3
     ;;; = 'write"x[";'
     writes "x["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"]=";'
     writes "]="
     ;;; = 'writex[i];'
     %19 = x[i]
     writei %19
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %20 = 1
     %21 = i + %20
     i = %21
     goto while3
  label endwhile3 :
     return
endfunction


