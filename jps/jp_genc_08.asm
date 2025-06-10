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
     %10 = 0
     %8 = A
     %15 = 1
     %16 = 10
     %9 = 1
  label while2 :
     %14 = %9 < %16
     ifFalse %14 goto endwhile2
     pushparam 
     %11 = %8
     pushparam %11
     %13 = A[%9]
     %12 = %13
     pushparam %12
     call catorze
     popparam 
     popparam 
     popparam %8
     %9 = %9 + %15
     goto while2
  label endwhile2 :
     %17 = 10.0
     %19 = float %8
     %18 = %19 /. %17
     r = %18
     ;;; = 'writer;'
     writef r
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'k=reduce(A,catorze);'
     %22 = 0
     %20 = A
     %27 = 1
     %28 = 10
     %21 = 1
  label while3 :
     %26 = %21 < %28
     ifFalse %26 goto endwhile3
     pushparam 
     %23 = %20
     pushparam %23
     %25 = A[%21]
     %24 = %25
     pushparam %24
     call catorze
     popparam 
     popparam 
     popparam %20
     %21 = %21 + %27
     goto while3
  label endwhile3 :
     k = %20
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'B[0]=A[3];'
     %29 = 0
     %30 = 3
     %31 = A[%30]
     B[%29] = %31
     ;;; = 'writereduce(B,catorze);'
     %34 = 0
     %32 = B
     %39 = 1
     %40 = 1
     %33 = 1
  label while4 :
     %38 = %33 < %40
     ifFalse %38 goto endwhile4
     pushparam 
     %35 = %32
     pushparam %35
     %37 = B[%33]
     %36 = %37
     pushparam %36
     call catorze
     popparam 
     popparam 
     popparam %32
     %33 = %33 + %39
     goto while4
  label endwhile4 :
     writei %32
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'B[0]=A[6];'
     %41 = 0
     %42 = 6
     %43 = A[%42]
     B[%41] = %43
     ;;; = 'writereduce(B,catorze);'
     %46 = 0
     %44 = B
     %51 = 1
     %52 = 1
     %45 = 1
  label while5 :
     %50 = %45 < %52
     ifFalse %50 goto endwhile5
     pushparam 
     %47 = %44
     pushparam %47
     %49 = B[%45]
     %48 = %49
     pushparam %48
     call catorze
     popparam 
     popparam 
     popparam %44
     %45 = %45 + %51
     goto while5
  label endwhile5 :
     writei %44
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=0;'
     %53 = 0
     i = %53
     ;;; = 'whilei<12doreadAC[i];i=i+1;endwhile'
  label while6 :
     %54 = 12
     %55 = i < %54
     ifFalse %55 goto endwhile6
     ;;; = 'readAC[i];'
     readc %56
     AC[i] = %56
     ;;; = 'i=i+1;'
     %57 = 1
     %58 = i + %57
     i = %58
     goto while6
  label endwhile6 :
     ;;; = 'c=reduce(AC,lletraF);'
     %61 = 0
     %59 = AC
     %66 = 1
     %67 = 12
     %60 = 1
  label while7 :
     %65 = %60 < %67
     ifFalse %65 goto endwhile7
     pushparam 
     %62 = %59
     pushparam %62
     %64 = AC[%60]
     %63 = %64
     pushparam %63
     call lletraF
     popparam 
     popparam 
     popparam %59
     %60 = %60 + %66
     goto while7
  label endwhile7 :
     c = %59
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'BC[0]=AC[7];'
     %68 = 0
     %69 = 7
     %70 = AC[%69]
     BC[%68] = %70
     ;;; = 'c=reduce(BC,lletraF);'
     %73 = 0
     %71 = BC
     %78 = 1
     %79 = 1
     %72 = 1
  label while8 :
     %77 = %72 < %79
     ifFalse %77 goto endwhile8
     pushparam 
     %74 = %71
     pushparam %74
     %76 = BC[%72]
     %75 = %76
     pushparam %75
     call lletraF
     popparam 
     popparam 
     popparam %71
     %72 = %72 + %78
     goto while8
  label endwhile8 :
     c = %71
     ;;; = 'writec;'
     writec c
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


