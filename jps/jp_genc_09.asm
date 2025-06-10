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
     %5 = i
     A[%5] = %4
     ;;; = 'B[i]=(A[i]%2==0);'
     %7 = i
     %6 = A[%7]
     %8 = 2
     %9 = %6 / %8
     %9 = %8 * %9
     %9 = %6 - %9
     %10 = 0
     %11 = %9 == %10
     %12 = i
     B[%12] = %11
     ;;; = 'i=i-1;'
     %13 = 1
     %14 = i - %13
     i = %14
     goto while1
  label endwhile1 :
     ;;; = 'r=reduce(A,suma)/10.0;'
     %17 = 0
     %19 = %17
     %18 = A[%19]
     %15 = %18
     %25 = 1
     %26 = 10
     %16 = 1
  label while2 :
     %24 = %16 < %26
     ifFalse %24 goto endwhile2
     pushparam 
     %20 = %15
     pushparam %20
     %23 = %16
     %22 = A[%23]
     %21 = %22
     pushparam %21
     call suma
     popparam 
     popparam 
     popparam %15
     %16 = %16 + %25
     goto while2
  label endwhile2 :
     %27 = 10.0
     %29 = float %15
     %28 = %29 /. %27
     r = %28
     ;;; = 'writer;'
     writef r
     ;;; = 'write'\n';'
     %30 = '\n'
     writec %30
     ;;; = 'k=reduce(A,minim);'
     %33 = 0
     %35 = %33
     %34 = A[%35]
     %31 = %34
     %41 = 1
     %42 = 10
     %32 = 1
  label while3 :
     %40 = %32 < %42
     ifFalse %40 goto endwhile3
     pushparam 
     %36 = %31
     pushparam %36
     %39 = %32
     %38 = A[%39]
     %37 = %38
     pushparam %37
     call minim
     popparam 
     popparam 
     popparam %31
     %32 = %32 + %41
     goto while3
  label endwhile3 :
     k = %31
     ;;; = 'writek;'
     writei k
     ;;; = 'write'\n';'
     %43 = '\n'
     writec %43
     ;;; = 'k=reduce(A,resta);'
     %46 = 0
     %48 = %46
     %47 = A[%48]
     %44 = %47
     %54 = 1
     %55 = 10
     %45 = 1
  label while4 :
     %53 = %45 < %55
     ifFalse %53 goto endwhile4
     pushparam 
     %49 = %44
     pushparam %49
     %52 = %45
     %51 = A[%52]
     %50 = %51
     pushparam %50
     call resta
     popparam 
     popparam 
     popparam %44
     %45 = %45 + %54
     goto while4
  label endwhile4 :
     k = %44
     ;;; = 'writek;'
     writei k
     ;;; = 'write'\n';'
     %56 = '\n'
     writec %56
     ;;; = 'i=0;'
     %57 = 0
     i = %57
     ;;; = 'whilei<13doreadAC[i];i=i+1;endwhile'
  label while5 :
     %58 = 13
     %59 = i < %58
     ifFalse %59 goto endwhile5
     ;;; = 'readAC[i];'
     readc %60
     %61 = i
     AC[%61] = %60
     ;;; = 'i=i+1;'
     %62 = 1
     %63 = i + %62
     i = %63
     goto while5
  label endwhile5 :
     ;;; = 'c=reduce(AC,maximC);'
     %66 = 0
     %68 = %66
     %67 = AC[%68]
     %64 = %67
     %74 = 1
     %75 = 13
     %65 = 1
  label while6 :
     %73 = %65 < %75
     ifFalse %73 goto endwhile6
     pushparam 
     %69 = %64
     pushparam %69
     %72 = %65
     %71 = AC[%72]
     %70 = %71
     pushparam %70
     call maximC
     popparam 
     popparam 
     popparam %64
     %65 = %65 + %74
     goto while6
  label endwhile6 :
     c = %64
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'ifreduce(B,AND)thenwrite"all even\n";elsewrite"some odd\n";endif'
     %78 = 0
     %80 = %78
     %79 = B[%80]
     %76 = %79
     %86 = 1
     %87 = 10
     %77 = 1
  label while7 :
     %85 = %77 < %87
     ifFalse %85 goto endwhile7
     pushparam 
     %81 = %76
     pushparam %81
     %84 = %77
     %83 = B[%84]
     %82 = %83
     pushparam %82
     call AND
     popparam 
     popparam 
     popparam %76
     %77 = %77 + %86
     goto while7
  label endwhile7 :
     ifFalse %76 goto else_if_1
     ;;; = 'write"all even\n";'
     writes "all even\n"
     goto exit_if_1
  label else_if_1 :
     ;;; = 'write"some odd\n";'
     writes "some odd\n"
  label exit_if_1 :
     return
endfunction


