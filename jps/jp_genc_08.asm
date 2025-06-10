function catorze
  params
    _result integer
    n integer
    m integer
  endparams

   ;;; = 'return14;'
   %1 = 14
   _result = %1
   return
   return
endfunction

function lletraF
  params
    _result character
    c1 character
    c2 character
  endparams

   ;;; = 'return'F';'
   %1 = 'F'
   _result = %1
   return
   return
endfunction

function main
  vars
    A integer 10
    B integer
    i integer
    k integer
    r float
    c character
    AC character 12
    BC character
  endvars

     ;;; = 'i=9;'
     %1 = 9
     i = %1
     ;;; = 'whilei>=0doreadA[i];write"A[";writei;write"]=";writeA[i];write"\n";i=i-1;endwhile'
  label while1 :
     %2 = 0
     %3 = i < %2
     %3 = not %3
     ifFalse %3 goto endwhile1
     ;;; = 'readA[i];'
     readi %4
     A[i] = %4
     ;;; = 'write"A[";'
     writes "A["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"]=";'
     writes "]="
     ;;; = 'writeA[i];'
     %5 = A[i]
     writei %5
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i-1;'
     %6 = 1
     %7 = i - %6
     i = %7
     goto while1
  label endwhile1 :
     ;;; = 'r=reduce(A,catorze)/10.0;'
     %11 = 0
     %12 = A[%11]
     %8 = %12
     %17 = 1
     %18 = 10
     %10 = 1
  label while2 :
     %16 = %10 < %18
     ifFalse %16 goto endwhile2
     %13 = A[%10]
     %9 = %13
     pushparam 
     %14 = %8
     pushparam %14
     %15 = %9
     pushparam %15
     call catorze
     popparam 
     popparam 
     popparam %8
     %10 = %10 + %17
     goto while2
  label endwhile2 :
     %19 = 10.0
     %21 = float %8
     %20 = %21 /. %19
     r = %20
     ;;; = 'writer;'
     writef r
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,catorze);'
     %25 = 0
     %26 = A[%25]
     %22 = %26
     %31 = 1
     %32 = 10
     %24 = 1
  label while3 :
     %30 = %24 < %32
     ifFalse %30 goto endwhile3
     %27 = A[%24]
     %23 = %27
     pushparam 
     %28 = %22
     pushparam %28
     %29 = %23
     pushparam %29
     call catorze
     popparam 
     popparam 
     popparam %22
     %24 = %24 + %31
     goto while3
  label endwhile3 :
     k = %22
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'B[0]=A[3];'
     %33 = 0
     %34 = 3
     %35 = A[%34]
     B[%33] = %35
     ;;; = 'writereduce(B,catorze);'
     %39 = 0
     %40 = B[%39]
     %36 = %40
     %45 = 1
     %46 = 1
     %38 = 1
  label while4 :
     %44 = %38 < %46
     ifFalse %44 goto endwhile4
     %41 = B[%38]
     %37 = %41
     pushparam 
     %42 = %36
     pushparam %42
     %43 = %37
     pushparam %43
     call catorze
     popparam 
     popparam 
     popparam %36
     %38 = %38 + %45
     goto while4
  label endwhile4 :
     writei %36
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'B[0]=A[6];'
     %47 = 0
     %48 = 6
     %49 = A[%48]
     B[%47] = %49
     ;;; = 'writereduce(B,catorze);'
     %53 = 0
     %54 = B[%53]
     %50 = %54
     %59 = 1
     %60 = 1
     %52 = 1
  label while5 :
     %58 = %52 < %60
     ifFalse %58 goto endwhile5
     %55 = B[%52]
     %51 = %55
     pushparam 
     %56 = %50
     pushparam %56
     %57 = %51
     pushparam %57
     call catorze
     popparam 
     popparam 
     popparam %50
     %52 = %52 + %59
     goto while5
  label endwhile5 :
     writei %50
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=0;'
     %61 = 0
     i = %61
     ;;; = 'whilei<12doreadAC[i];i=i+1;endwhile'
  label while6 :
     %62 = 12
     %63 = i < %62
     ifFalse %63 goto endwhile6
     ;;; = 'readAC[i];'
     readc %64
     AC[i] = %64
     ;;; = 'i=i+1;'
     %65 = 1
     %66 = i + %65
     i = %66
     goto while6
  label endwhile6 :
     ;;; = 'c=reduce(AC,lletraF);'
     %70 = 0
     %71 = AC[%70]
     %67 = %71
     %76 = 1
     %77 = 12
     %69 = 1
  label while7 :
     %75 = %69 < %77
     ifFalse %75 goto endwhile7
     %72 = AC[%69]
     %68 = %72
     pushparam 
     %73 = %67
     pushparam %73
     %74 = %68
     pushparam %74
     call lletraF
     popparam 
     popparam 
     popparam %67
     %69 = %69 + %76
     goto while7
  label endwhile7 :
     c = %67
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'BC[0]=AC[7];'
     %78 = 0
     %79 = 7
     %80 = AC[%79]
     BC[%78] = %80
     ;;; = 'c=reduce(BC,lletraF);'
     %84 = 0
     %85 = BC[%84]
     %81 = %85
     %90 = 1
     %91 = 1
     %83 = 1
  label while8 :
     %89 = %83 < %91
     ifFalse %89 goto endwhile8
     %86 = BC[%83]
     %82 = %86
     pushparam 
     %87 = %81
     pushparam %87
     %88 = %82
     pushparam %88
     call lletraF
     popparam 
     popparam 
     popparam %81
     %83 = %83 + %90
     goto while8
  label endwhile8 :
     c = %81
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


