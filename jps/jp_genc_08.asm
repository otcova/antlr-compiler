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
     %5 = i
     A[%5] = %4
     ;;; = 'write"A[";'
     writes "A["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"]=";'
     writes "]="
     ;;; = 'writeA[i];'
     %7 = i
     %6 = A[%7]
     writei %6
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i-1;'
     %8 = 1
     %9 = i - %8
     i = %9
     goto while1
  label endwhile1 :
     ;;; = 'r=reduce(A,catorze)/10.0;'
     %12 = 0
     %14 = %12
     %13 = A[%14]
     %10 = %13
     %20 = 1
     %21 = 10
     %11 = 1
  label while2 :
     %19 = %11 < %21
     ifFalse %19 goto endwhile2
     pushparam 
     %15 = %10
     pushparam %15
     %18 = %11
     %17 = A[%18]
     %16 = %17
     pushparam %16
     call catorze
     popparam 
     popparam 
     popparam %10
     %11 = %11 + %20
     goto while2
  label endwhile2 :
     %22 = 10.0
     %24 = float %10
     %23 = %24 /. %22
     r = %23
     ;;; = 'writer;'
     writef r
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,catorze);'
     %27 = 0
     %29 = %27
     %28 = A[%29]
     %25 = %28
     %35 = 1
     %36 = 10
     %26 = 1
  label while3 :
     %34 = %26 < %36
     ifFalse %34 goto endwhile3
     pushparam 
     %30 = %25
     pushparam %30
     %33 = %26
     %32 = A[%33]
     %31 = %32
     pushparam %31
     call catorze
     popparam 
     popparam 
     popparam %25
     %26 = %26 + %35
     goto while3
  label endwhile3 :
     k = %25
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'B[0]=A[3];'
     %37 = 0
     %38 = 3
     %40 = %38
     %39 = A[%40]
     %41 = %37
     B[%41] = %39
     ;;; = 'writereduce(B,catorze);'
     %44 = 0
     %46 = %44
     %45 = B[%46]
     %42 = %45
     %52 = 1
     %53 = 1
     %43 = 1
  label while4 :
     %51 = %43 < %53
     ifFalse %51 goto endwhile4
     pushparam 
     %47 = %42
     pushparam %47
     %50 = %43
     %49 = B[%50]
     %48 = %49
     pushparam %48
     call catorze
     popparam 
     popparam 
     popparam %42
     %43 = %43 + %52
     goto while4
  label endwhile4 :
     writei %42
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'B[0]=A[6];'
     %54 = 0
     %55 = 6
     %57 = %55
     %56 = A[%57]
     %58 = %54
     B[%58] = %56
     ;;; = 'writereduce(B,catorze);'
     %61 = 0
     %63 = %61
     %62 = B[%63]
     %59 = %62
     %69 = 1
     %70 = 1
     %60 = 1
  label while5 :
     %68 = %60 < %70
     ifFalse %68 goto endwhile5
     pushparam 
     %64 = %59
     pushparam %64
     %67 = %60
     %66 = B[%67]
     %65 = %66
     pushparam %65
     call catorze
     popparam 
     popparam 
     popparam %59
     %60 = %60 + %69
     goto while5
  label endwhile5 :
     writei %59
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=0;'
     %71 = 0
     i = %71
     ;;; = 'whilei<12doreadAC[i];i=i+1;endwhile'
  label while6 :
     %72 = 12
     %73 = i < %72
     ifFalse %73 goto endwhile6
     ;;; = 'readAC[i];'
     readc %74
     %75 = i
     AC[%75] = %74
     ;;; = 'i=i+1;'
     %76 = 1
     %77 = i + %76
     i = %77
     goto while6
  label endwhile6 :
     ;;; = 'c=reduce(AC,lletraF);'
     %80 = 0
     %82 = %80
     %81 = AC[%82]
     %78 = %81
     %88 = 1
     %89 = 12
     %79 = 1
  label while7 :
     %87 = %79 < %89
     ifFalse %87 goto endwhile7
     pushparam 
     %83 = %78
     pushparam %83
     %86 = %79
     %85 = AC[%86]
     %84 = %85
     pushparam %84
     call lletraF
     popparam 
     popparam 
     popparam %78
     %79 = %79 + %88
     goto while7
  label endwhile7 :
     c = %78
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'BC[0]=AC[7];'
     %90 = 0
     %91 = 7
     %93 = %91
     %92 = AC[%93]
     %94 = %90
     BC[%94] = %92
     ;;; = 'c=reduce(BC,lletraF);'
     %97 = 0
     %99 = %97
     %98 = BC[%99]
     %95 = %98
     %105 = 1
     %106 = 1
     %96 = 1
  label while8 :
     %104 = %96 < %106
     ifFalse %104 goto endwhile8
     pushparam 
     %100 = %95
     pushparam %100
     %103 = %96
     %102 = BC[%103]
     %101 = %102
     pushparam %101
     call lletraF
     popparam 
     popparam 
     popparam %95
     %96 = %96 + %105
     goto while8
  label endwhile8 :
     c = %95
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


