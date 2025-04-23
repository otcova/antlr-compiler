function f
  params
    v integer array
  endparams

  vars
    c integer 10
    i integer
  endvars

     ;;; = 'c=v;'
     c = v
     ;;; = 'write"en f. c: ";'
     writes "en f. c: "
     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10dowritec[i];write' ';i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'writec[i];'
     %4 = c[i]
     writei %4
     ;;; = 'write' ';'
     %5 = ' '
     writec %5
     ;;; = 'i=i+1;'
     %6 = 1
     %7 = i + %6
     i = %7
     goto while1
  label endwhile1 :
     ;;; = 'write'\n';'
     %8 = '\n'
     writec %8
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
     v = d
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
     b = a
     ;;; = 'write"despres de b=a. b: ";'
     writes "despres de b=a. b: "
     ;;; = 'i=0;'
     %7 = 0
     i = %7
     ;;; = 'whilei<10dowriteb[i];write' ';i=i+1;endwhile'
  label while2 :
     %8 = 10
     %9 = i < %8
     ifFalse %9 goto endwhile2
     ;;; = 'writeb[i];'
     %10 = b[i]
     writei %10
     ;;; = 'write' ';'
     %11 = ' '
     writec %11
     ;;; = 'i=i+1;'
     %12 = 1
     %13 = i + %12
     i = %13
     goto while2
  label endwhile2 :
     ;;; = 'write'\n';'
     %14 = '\n'
     writec %14
     ;;; = 'write"despres de b=a. a: ";'
     writes "despres de b=a. a: "
     ;;; = 'i=0;'
     %15 = 0
     i = %15
     ;;; = 'whilei<10dowritea[i];write' ';i=i+1;endwhile'
  label while3 :
     %16 = 10
     %17 = i < %16
     ifFalse %17 goto endwhile3
     ;;; = 'writea[i];'
     %18 = a[i]
     writei %18
     ;;; = 'write' ';'
     %19 = ' '
     writec %19
     ;;; = 'i=i+1;'
     %20 = 1
     %21 = i + %20
     i = %21
     goto while3
  label endwhile3 :
     ;;; = 'write'\n';'
     %22 = '\n'
     writec %22
     ;;; = 'f(a);'
     %23 = &a
     pushparam %23
     call f
     popparam 
     ;;; = 'write"despres de f(a). a: ";'
     writes "despres de f(a). a: "
     ;;; = 'i=0;'
     %24 = 0
     i = %24
     ;;; = 'whilei<10dowritea[i];write' ';i=i+1;endwhile'
  label while4 :
     %25 = 10
     %26 = i < %25
     ifFalse %26 goto endwhile4
     ;;; = 'writea[i];'
     %27 = a[i]
     writei %27
     ;;; = 'write' ';'
     %28 = ' '
     writec %28
     ;;; = 'i=i+1;'
     %29 = 1
     %30 = i + %29
     i = %30
     goto while4
  label endwhile4 :
     ;;; = 'write'\n';'
     %31 = '\n'
     writec %31
     ;;; = 'g(a);'
     %32 = &a
     pushparam %32
     call g
     popparam 
     ;;; = 'write"despres de g(a). a: ";'
     writes "despres de g(a). a: "
     ;;; = 'i=0;'
     %33 = 0
     i = %33
     ;;; = 'whilei<10dowritea[i];write' ';i=i+1;endwhile'
  label while5 :
     %34 = 10
     %35 = i < %34
     ifFalse %35 goto endwhile5
     ;;; = 'writea[i];'
     %36 = a[i]
     writei %36
     ;;; = 'write' ';'
     %37 = ' '
     writec %37
     ;;; = 'i=i+1;'
     %38 = 1
     %39 = i + %38
     i = %39
     goto while5
  label endwhile5 :
     ;;; = 'write'\n';'
     %40 = '\n'
     writec %40
     return
endfunction


