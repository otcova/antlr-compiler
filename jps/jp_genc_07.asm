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
     %7 = 0
     %8 = A[0]
     %5 = %8
     %13 = 1
     %14 = 1
     %6 = 1
  label while1 :
     %12 = %6 < %14
     ifFalse %12 goto endwhile1
     pushparam 
     %9 = %5
     pushparam %9
     %11 = A[%6]
     %10 = %11
     pushparam %10
     call suma
     popparam 
     popparam 
     popparam %5
     %6 = %6 + %13
     goto while1
  label endwhile1 :
     %15 = 10.0
     %17 = float %5
     %16 = %17 /. %15
     r = %16
     ;;; = 'writer;'
     writef r
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,minim);'
     %20 = 0
     %21 = A[0]
     %18 = %21
     %26 = 1
     %27 = 1
     %19 = 1
  label while2 :
     %25 = %19 < %27
     ifFalse %25 goto endwhile2
     pushparam 
     %22 = %18
     pushparam %22
     %24 = A[%19]
     %23 = %24
     pushparam %23
     call minim
     popparam 
     popparam 
     popparam %18
     %19 = %19 + %26
     goto while2
  label endwhile2 :
     k = %18
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,maxim);'
     %30 = 0
     %31 = A[0]
     %28 = %31
     %36 = 1
     %37 = 1
     %29 = 1
  label while3 :
     %35 = %29 < %37
     ifFalse %35 goto endwhile3
     pushparam 
     %32 = %28
     pushparam %32
     %34 = A[%29]
     %33 = %34
     pushparam %33
     call maxim
     popparam 
     popparam 
     popparam %28
     %29 = %29 + %36
     goto while3
  label endwhile3 :
     k = %28
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'AC[0]='h';'
     %38 = 0
     %39 = 'h'
     AC[%38] = %39
     ;;; = 'c=reduce(AC,maximC);'
     %42 = 0
     %43 = AC[0]
     %40 = %43
     %48 = 1
     %49 = 1
     %41 = 1
  label while4 :
     %47 = %41 < %49
     ifFalse %47 goto endwhile4
     pushparam 
     %44 = %40
     pushparam %44
     %46 = AC[%41]
     %45 = %46
     pushparam %45
     call maximC
     popparam 
     popparam 
     popparam %40
     %41 = %41 + %48
     goto while4
  label endwhile4 :
     c = %40
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


