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

function resta
  params
    _result integer
    n integer
    m integer
  endparams

   ;;; = 'returnn-m;'
   %1 = n - m
   _result = %1
   return
   return
endfunction

function AND
  params
    _result boolean
    a boolean
    b boolean
  endparams

   ;;; = 'returnaandb;'
   %1 = a and b
   _result = %1
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
    A integer 10
    B boolean 10
    i integer
    k integer
    r float
    c character
    AC character 13
  endvars

     ;;; = 'i=9;'
     %1 = 9
     i = %1
     ;;; = 'whilei>=0doreadA[i];B[i]=(A[i]%2==0);i=i-1;endwhile'
  label while1 :
     %2 = 0
     %3 = i < %2
     %3 = not %3
     ifFalse %3 goto endwhile1
     ;;; = 'readA[i];'
     readi %4
     A[i] = %4
     ;;; = 'B[i]=(A[i]%2==0);'
     %5 = A[i]
     %6 = 2
     %7 = %5 / %6
     %7 = %6 * %7
     %7 = %5 - %7
     %8 = 0
     %9 = %7 == %8
     B[i] = %9
     ;;; = 'i=i-1;'
     %10 = 1
     %11 = i - %10
     i = %11
     goto while1
  label endwhile1 :
     ;;; = 'r=reduce(A,suma)/10.0;'
     %14 = 0
     %12 = A
     %19 = 1
     %20 = 10
     %13 = 1
  label while2 :
     %18 = %13 < %20
     ifFalse %18 goto endwhile2
     pushparam 
     %15 = %12
     pushparam %15
     %17 = A[%13]
     %16 = %17
     pushparam %16
     call suma
     popparam 
     popparam 
     popparam %12
     %13 = %13 + %19
     goto while2
  label endwhile2 :
     %21 = 10.0
     %23 = float %12
     %22 = %23 /. %21
     r = %22
     ;;; = 'writer;'
     writef r
     ;;; = 'write'\n';'
     %24 = '\n'
     writec %24
     ;;; = 'k=reduce(A,minim);'
     %27 = 0
     %25 = A
     %32 = 1
     %33 = 10
     %26 = 1
  label while3 :
     %31 = %26 < %33
     ifFalse %31 goto endwhile3
     pushparam 
     %28 = %25
     pushparam %28
     %30 = A[%26]
     %29 = %30
     pushparam %29
     call minim
     popparam 
     popparam 
     popparam %25
     %26 = %26 + %32
     goto while3
  label endwhile3 :
     k = %25
     ;;; = 'writek;'
     writei k
     ;;; = 'write'\n';'
     %34 = '\n'
     writec %34
     ;;; = 'k=reduce(A,resta);'
     %37 = 0
     %35 = A
     %42 = 1
     %43 = 10
     %36 = 1
  label while4 :
     %41 = %36 < %43
     ifFalse %41 goto endwhile4
     pushparam 
     %38 = %35
     pushparam %38
     %40 = A[%36]
     %39 = %40
     pushparam %39
     call resta
     popparam 
     popparam 
     popparam %35
     %36 = %36 + %42
     goto while4
  label endwhile4 :
     k = %35
     ;;; = 'writek;'
     writei k
     ;;; = 'write'\n';'
     %44 = '\n'
     writec %44
     ;;; = 'i=0;'
     %45 = 0
     i = %45
     ;;; = 'whilei<13doreadAC[i];i=i+1;endwhile'
  label while5 :
     %46 = 13
     %47 = i < %46
     ifFalse %47 goto endwhile5
     ;;; = 'readAC[i];'
     readc %48
     AC[i] = %48
     ;;; = 'i=i+1;'
     %49 = 1
     %50 = i + %49
     i = %50
     goto while5
  label endwhile5 :
     ;;; = 'c=reduce(AC,maximC);'
     %53 = 0
     %51 = AC
     %58 = 1
     %59 = 13
     %52 = 1
  label while6 :
     %57 = %52 < %59
     ifFalse %57 goto endwhile6
     pushparam 
     %54 = %51
     pushparam %54
     %56 = AC[%52]
     %55 = %56
     pushparam %55
     call maximC
     popparam 
     popparam 
     popparam %51
     %52 = %52 + %58
     goto while6
  label endwhile6 :
     c = %51
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'ifreduce(B,AND)thenwrite"all even\n";elsewrite"some odd\n";endif'
     %62 = 0
     %60 = B
     %67 = 1
     %68 = 10
     %61 = 1
  label while7 :
     %66 = %61 < %68
     ifFalse %66 goto endwhile7
     pushparam 
     %63 = %60
     pushparam %63
     %65 = B[%61]
     %64 = %65
     pushparam %64
     call AND
     popparam 
     popparam 
     popparam %60
     %61 = %61 + %67
     goto while7
  label endwhile7 :
     ifFalse %60 goto else_if_1
     ;;; = 'write"all even\n";'
     writes "all even\n"
     goto exit_if_1
  label else_if_1 :
     ;;; = 'write"some odd\n";'
     writes "some odd\n"
  label exit_if_1 :
     return
endfunction


