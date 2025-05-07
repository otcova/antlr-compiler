function f
  params
    v integer array
  endparams

  vars
    c integer 10
    i integer
  endvars

     ;;; = 'c=v;'
     %1 = 0
  label while1 :
     %4 = %1 < 10
     ifFalse %4 goto endwhile1
     %2 = v
     %3 = %2[%1]
     c[%1] = %3
     %1 = %1 + 1
     goto while1
  label endwhile1 :
     ;;; = 'write"en f. c: ";'
     writes "en f. c: "
     ;;; = 'i=0;'
     %5 = 0
     i = %5
     ;;; = 'whilei<10dowritec[i];write' ';i=i+1;endwhile'
  label while2 :
     %6 = 10
     %7 = i < %6
     ifFalse %7 goto endwhile2
     ;;; = 'writec[i];'
     %8 = c[i]
     writei %8
     ;;; = 'write' ';'
     %9 = ' '
     writec %9
     ;;; = 'i=i+1;'
     %10 = 1
     %11 = i + %10
     i = %11
     goto while2
  label endwhile2 :
     ;;; = 'write'\n';'
     %12 = '\n'
     writec %12
     return
endfunction

function g
  params
    v integer array
  endparams

  vars
    d integer 10
    i integer
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10dod[i]=-1;i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'd[i]=-1;'
     %4 = 1
     %5 = - %4
     d[i] = %5
     ;;; = 'i=i+1;'
     %6 = 1
     %7 = i + %6
     i = %7
     goto while1
  label endwhile1 :
     ;;; = 'v=d;'
     %8 = 0
  label while2 :
     %11 = %8 < 10
     ifFalse %11 goto endwhile2
     %9 = d[%8]
     %10 = v
     %10[%8] = %9
     %8 = %8 + 1
     goto while2
  label endwhile2 :
     return
endfunction

function main
  vars
    a integer 10
    b integer 10
    i integer
    j integer
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10doa[i]=i;b[i]=0;i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'a[i]=i;'
     a[i] = i
     ;;; = 'b[i]=0;'
     %4 = 0
     b[i] = %4
     ;;; = 'i=i+1;'
     %5 = 1
     %6 = i + %5
     i = %6
     goto while1
  label endwhile1 :
     ;;; = 'b=a;'
     %7 = 0
  label while2 :
     %9 = %7 < 10
     ifFalse %9 goto endwhile2
     %8 = a[%7]
     b[%7] = %8
     %7 = %7 + 1
     goto while2
  label endwhile2 :
     ;;; = 'write"despres de b=a. b: ";'
     writes "despres de b=a. b: "
     ;;; = 'i=0;'
     %10 = 0
     i = %10
     ;;; = 'whilei<10dowriteb[i];write' ';i=i+1;endwhile'
  label while3 :
     %11 = 10
     %12 = i < %11
     ifFalse %12 goto endwhile3
     ;;; = 'writeb[i];'
     %13 = b[i]
     writei %13
     ;;; = 'write' ';'
     %14 = ' '
     writec %14
     ;;; = 'i=i+1;'
     %15 = 1
     %16 = i + %15
     i = %16
     goto while3
  label endwhile3 :
     ;;; = 'write'\n';'
     %17 = '\n'
     writec %17
     ;;; = 'write"despres de b=a. a: ";'
     writes "despres de b=a. a: "
     ;;; = 'i=0;'
     %18 = 0
     i = %18
     ;;; = 'whilei<10dowritea[i];write' ';i=i+1;endwhile'
  label while4 :
     %19 = 10
     %20 = i < %19
     ifFalse %20 goto endwhile4
     ;;; = 'writea[i];'
     %21 = a[i]
     writei %21
     ;;; = 'write' ';'
     %22 = ' '
     writec %22
     ;;; = 'i=i+1;'
     %23 = 1
     %24 = i + %23
     i = %24
     goto while4
  label endwhile4 :
     ;;; = 'write'\n';'
     %25 = '\n'
     writec %25
     ;;; = 'f(a);'
     %26 = &a
     pushparam %26
     call f
     popparam 
     ;;; = 'write"despres de f(a). a: ";'
     writes "despres de f(a). a: "
     ;;; = 'i=0;'
     %27 = 0
     i = %27
     ;;; = 'whilei<10dowritea[i];write' ';i=i+1;endwhile'
  label while5 :
     %28 = 10
     %29 = i < %28
     ifFalse %29 goto endwhile5
     ;;; = 'writea[i];'
     %30 = a[i]
     writei %30
     ;;; = 'write' ';'
     %31 = ' '
     writec %31
     ;;; = 'i=i+1;'
     %32 = 1
     %33 = i + %32
     i = %33
     goto while5
  label endwhile5 :
     ;;; = 'write'\n';'
     %34 = '\n'
     writec %34
     ;;; = 'g(a);'
     %35 = &a
     pushparam %35
     call g
     popparam 
     ;;; = 'write"despres de g(a). a: ";'
     writes "despres de g(a). a: "
     ;;; = 'i=0;'
     %36 = 0
     i = %36
     ;;; = 'whilei<10dowritea[i];write' ';i=i+1;endwhile'
  label while6 :
     %37 = 10
     %38 = i < %37
     ifFalse %38 goto endwhile6
     ;;; = 'writea[i];'
     %39 = a[i]
     writei %39
     ;;; = 'write' ';'
     %40 = ' '
     writec %40
     ;;; = 'i=i+1;'
     %41 = 1
     %42 = i + %41
     i = %42
     goto while6
  label endwhile6 :
     ;;; = 'write'\n';'
     %43 = '\n'
     writec %43
     return
endfunction


