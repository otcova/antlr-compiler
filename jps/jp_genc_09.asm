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
     %15 = 0
     %16 = A[%15]
     %12 = %16
     %21 = 1
     %22 = 10
     %14 = 1
  label while2 :
     %20 = %14 < %22
     ifFalse %20 goto endwhile2
     %17 = A[%14]
     %13 = %17
     pushparam 
     %18 = %12
     pushparam %18
     %19 = %13
     pushparam %19
     call suma
     popparam 
     popparam 
     popparam %12
     %14 = %14 + %21
     goto while2
  label endwhile2 :
     %23 = 10.0
     %25 = float %12
     %24 = %25 /. %23
     r = %24
     ;;; = 'writer;'
     writef r
     ;;; = 'write'\n';'
     %26 = '\n'
     writec %26
     ;;; = 'k=reduce(A,minim);'
     %30 = 0
     %31 = A[%30]
     %27 = %31
     %36 = 1
     %37 = 10
     %29 = 1
  label while3 :
     %35 = %29 < %37
     ifFalse %35 goto endwhile3
     %32 = A[%29]
     %28 = %32
     pushparam 
     %33 = %27
     pushparam %33
     %34 = %28
     pushparam %34
     call minim
     popparam 
     popparam 
     popparam %27
     %29 = %29 + %36
     goto while3
  label endwhile3 :
     k = %27
     ;;; = 'writek;'
     writei k
     ;;; = 'write'\n';'
     %38 = '\n'
     writec %38
     ;;; = 'k=reduce(A,resta);'
     %42 = 0
     %43 = A[%42]
     %39 = %43
     %48 = 1
     %49 = 10
     %41 = 1
  label while4 :
     %47 = %41 < %49
     ifFalse %47 goto endwhile4
     %44 = A[%41]
     %40 = %44
     pushparam 
     %45 = %39
     pushparam %45
     %46 = %40
     pushparam %46
     call resta
     popparam 
     popparam 
     popparam %39
     %41 = %41 + %48
     goto while4
  label endwhile4 :
     k = %39
     ;;; = 'writek;'
     writei k
     ;;; = 'write'\n';'
     %50 = '\n'
     writec %50
     ;;; = 'i=0;'
     %51 = 0
     i = %51
     ;;; = 'whilei<13doreadAC[i];i=i+1;endwhile'
  label while5 :
     %52 = 13
     %53 = i < %52
     ifFalse %53 goto endwhile5
     ;;; = 'readAC[i];'
     readc %54
     AC[i] = %54
     ;;; = 'i=i+1;'
     %55 = 1
     %56 = i + %55
     i = %56
     goto while5
  label endwhile5 :
     ;;; = 'c=reduce(AC,maximC);'
     %60 = 0
     %61 = AC[%60]
     %57 = %61
     %66 = 1
     %67 = 13
     %59 = 1
  label while6 :
     %65 = %59 < %67
     ifFalse %65 goto endwhile6
     %62 = AC[%59]
     %58 = %62
     pushparam 
     %63 = %57
     pushparam %63
     %64 = %58
     pushparam %64
     call maximC
     popparam 
     popparam 
     popparam %57
     %59 = %59 + %66
     goto while6
  label endwhile6 :
     c = %57
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'ifreduce(B,AND)thenwrite"all even\n";elsewrite"some odd\n";endif'
     %71 = 0
     %72 = B[%71]
     %68 = %72
     %77 = 1
     %78 = 10
     %70 = 1
  label while7 :
     %76 = %70 < %78
     ifFalse %76 goto endwhile7
     %73 = B[%70]
     %69 = %73
     pushparam 
     %74 = %68
     pushparam %74
     %75 = %69
     pushparam %75
     call AND
     popparam 
     popparam 
     popparam %68
     %70 = %70 + %77
     goto while7
  label endwhile7 :
     ifFalse %68 goto else_if_1
     ;;; = 'write"all even\n";'
     writes "all even\n"
     goto exit_if_1
  label else_if_1 :
     ;;; = 'write"some odd\n";'
     writes "some odd\n"
  label exit_if_1 :
     return
endfunction


