function suma
  params
    _result integer
    n integer
    m integer
  endparams

   ;;; = 'returnn+m;'
   %1 = n + m
   _result = %1
   return
   return
endfunction

function minim
  params
    _result integer
    n integer
    m integer
  endparams

     ;;; = 'ifn<mthenreturnn;endif'
     %1 = n < m
     ifFalse %1 goto else_if_1
     ;;; = 'returnn;'
     _result = n
     return
     goto exit_if_1
  label else_if_1 :
  label exit_if_1 :
     ;;; = 'returnm;'
     _result = m
     return
     return
endfunction

function maxim
  params
    _result integer
    n integer
    m integer
  endparams

     ;;; = 'ifn>mthenreturnn;endif'
     %1 = n <= m
     %1 = not %1
     ifFalse %1 goto else_if_1
     ;;; = 'returnn;'
     _result = n
     return
     goto exit_if_1
  label else_if_1 :
  label exit_if_1 :
     ;;; = 'returnm;'
     _result = m
     return
     return
endfunction

function maximC
  params
    _result character
    c1 character
    c2 character
  endparams

     ;;; = 'ifc1>c2thenreturnc1;endif'
     %1 = c1 <= c2
     %1 = not %1
     ifFalse %1 goto else_if_1
     ;;; = 'returnc1;'
     _result = c1
     return
     goto exit_if_1
  label else_if_1 :
  label exit_if_1 :
     ;;; = 'returnc2;'
     _result = c2
     return
     return
endfunction

function main
  vars
    A integer
    i integer
    k integer
    r float
    c character
    AC character
  endvars

     ;;; = 'A[0]=231;'
     %1 = 0
     %2 = 231
     A[%1] = %2
     ;;; = 'write"A[0]=";'
     writes "A[0]="
     ;;; = 'writeA[0];'
     %3 = 0
     %4 = A[%3]
     writei %4
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'r=reduce(A,suma)/10.0;'
     %8 = 0
     %9 = A[%8]
     %5 = %9
     %14 = 1
     %15 = 1
     %7 = 1
  label while1 :
     %13 = %7 < %15
     ifFalse %13 goto endwhile1
     %10 = A[%7]
     %6 = %10
     pushparam 
     %11 = %5
     pushparam %11
     %12 = %6
     pushparam %12
     call suma
     popparam 
     popparam 
     popparam %5
     %7 = %7 + %14
     goto while1
  label endwhile1 :
     %16 = 10.0
     %18 = float %5
     %17 = %18 /. %16
     r = %17
     ;;; = 'writer;'
     writef r
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,minim);'
     %22 = 0
     %23 = A[%22]
     %19 = %23
     %28 = 1
     %29 = 1
     %21 = 1
  label while2 :
     %27 = %21 < %29
     ifFalse %27 goto endwhile2
     %24 = A[%21]
     %20 = %24
     pushparam 
     %25 = %19
     pushparam %25
     %26 = %20
     pushparam %26
     call minim
     popparam 
     popparam 
     popparam %19
     %21 = %21 + %28
     goto while2
  label endwhile2 :
     k = %19
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,maxim);'
     %33 = 0
     %34 = A[%33]
     %30 = %34
     %39 = 1
     %40 = 1
     %32 = 1
  label while3 :
     %38 = %32 < %40
     ifFalse %38 goto endwhile3
     %35 = A[%32]
     %31 = %35
     pushparam 
     %36 = %30
     pushparam %36
     %37 = %31
     pushparam %37
     call maxim
     popparam 
     popparam 
     popparam %30
     %32 = %32 + %39
     goto while3
  label endwhile3 :
     k = %30
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'AC[0]='h';'
     %41 = 0
     %42 = 'h'
     AC[%41] = %42
     ;;; = 'c=reduce(AC,maximC);'
     %46 = 0
     %47 = AC[%46]
     %43 = %47
     %52 = 1
     %53 = 1
     %45 = 1
  label while4 :
     %51 = %45 < %53
     ifFalse %51 goto endwhile4
     %48 = AC[%45]
     %44 = %48
     pushparam 
     %49 = %43
     pushparam %49
     %50 = %44
     pushparam %50
     call maximC
     popparam 
     popparam 
     popparam %43
     %45 = %45 + %52
     goto while4
  label endwhile4 :
     c = %43
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


