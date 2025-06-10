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
     %3 = %1
     A[%3] = %2
     ;;; = 'write"A[0]=";'
     writes "A[0]="
     ;;; = 'writeA[0];'
     %4 = 0
     %6 = %4
     %5 = A[%6]
     writei %5
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'r=reduce(A,suma)/10.0;'
     %9 = 0
     %11 = %9
     %10 = A[%11]
     %7 = %10
     %17 = 1
     %18 = 1
     %8 = 1
  label while1 :
     %16 = %8 < %18
     ifFalse %16 goto endwhile1
     pushparam 
     %12 = %7
     pushparam %12
     %15 = %8
     %14 = A[%15]
     %13 = %14
     pushparam %13
     call suma
     popparam 
     popparam 
     popparam %7
     %8 = %8 + %17
     goto while1
  label endwhile1 :
     %19 = 10.0
     %21 = float %7
     %20 = %21 /. %19
     r = %20
     ;;; = 'writer;'
     writef r
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,minim);'
     %24 = 0
     %26 = %24
     %25 = A[%26]
     %22 = %25
     %32 = 1
     %33 = 1
     %23 = 1
  label while2 :
     %31 = %23 < %33
     ifFalse %31 goto endwhile2
     pushparam 
     %27 = %22
     pushparam %27
     %30 = %23
     %29 = A[%30]
     %28 = %29
     pushparam %28
     call minim
     popparam 
     popparam 
     popparam %22
     %23 = %23 + %32
     goto while2
  label endwhile2 :
     k = %22
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,maxim);'
     %36 = 0
     %38 = %36
     %37 = A[%38]
     %34 = %37
     %44 = 1
     %45 = 1
     %35 = 1
  label while3 :
     %43 = %35 < %45
     ifFalse %43 goto endwhile3
     pushparam 
     %39 = %34
     pushparam %39
     %42 = %35
     %41 = A[%42]
     %40 = %41
     pushparam %40
     call maxim
     popparam 
     popparam 
     popparam %34
     %35 = %35 + %44
     goto while3
  label endwhile3 :
     k = %34
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'AC[0]='h';'
     %46 = 0
     %47 = 'h'
     %48 = %46
     AC[%48] = %47
     ;;; = 'c=reduce(AC,maximC);'
     %51 = 0
     %53 = %51
     %52 = AC[%53]
     %49 = %52
     %59 = 1
     %60 = 1
     %50 = 1
  label while4 :
     %58 = %50 < %60
     ifFalse %58 goto endwhile4
     pushparam 
     %54 = %49
     pushparam %54
     %57 = %50
     %56 = AC[%57]
     %55 = %56
     pushparam %55
     call maximC
     popparam 
     popparam 
     popparam %49
     %50 = %50 + %59
     goto while4
  label endwhile4 :
     c = %49
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


