function main
  vars
    a integer
    b integer
    A integer 2
    x float
    y float
  endvars

     ;;; = 'x=3;'
     %1 = 3
     %2 = float %1
     x = %2
     ;;; = 'a=1;'
     %3 = 1
     a = %3
     ;;; = 'readb;'
     readi %4
     b = %4
     ;;; = 'y=b!+x;'
     %11 = b < 0
     ifFalse %11 goto else_if_1
     halt "Invalid integer value in math operation."
     goto exit_if_1
  label else_if_1 :
     %7 = 1
     %6 = 1
     %9 = 0
     %10 = b
     %5 = 0
  label while1 :
     %8 = %5 < %10
     ifFalse %8 goto endwhile1
     %5 = %5 + %7
     %6 = %6 * %5
     %5 = %5 + %9
     goto while1
  label endwhile1 :
  label exit_if_1 :
     %13 = float %6
     %12 = %13 +. x
     y = %12
     ;;; = 'writey;'
     writef y
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'A[0]=8;'
     %14 = 0
     %15 = 8
     %16 = %14
     A[%16] = %15
     ;;; = 'A[1]=9;'
     %17 = 1
     %18 = 9
     %19 = %17
     A[%19] = %18
     ;;; = 'y=a!*x;'
     %26 = a < 0
     ifFalse %26 goto else_if_2
     halt "Invalid integer value in math operation."
     goto exit_if_2
  label else_if_2 :
     %22 = 1
     %21 = 1
     %24 = 0
     %25 = a
     %20 = 0
  label while2 :
     %23 = %20 < %25
     ifFalse %23 goto endwhile2
     %20 = %20 + %22
     %21 = %21 * %20
     %20 = %20 + %24
     goto while2
  label endwhile2 :
  label exit_if_2 :
     %28 = float %21
     %27 = %28 *. x
     y = %27
     ;;; = 'if(-b!+x<=(A[0]/2)!*a!)thenx=A[1]!-b;A[1]=(b-2)!!;write"A[1]=";writeA[1];write"\n";endif'
     %35 = b < 0
     ifFalse %35 goto else_if_3
     halt "Invalid integer value in math operation."
     goto exit_if_3
  label else_if_3 :
     %31 = 1
     %30 = 1
     %33 = 0
     %34 = b
     %29 = 0
  label while3 :
     %32 = %29 < %34
     ifFalse %32 goto endwhile3
     %29 = %29 + %31
     %30 = %30 * %29
     %29 = %29 + %33
     goto while3
  label endwhile3 :
  label exit_if_3 :
     %36 = - %30
     %38 = float %36
     %37 = %38 +. x
     %39 = 0
     %41 = %39
     %40 = A[%41]
     %42 = 2
     %43 = %40 / %42
     %50 = %43 < 0
     ifFalse %50 goto else_if_4
     halt "Invalid integer value in math operation."
     goto exit_if_4
  label else_if_4 :
     %46 = 1
     %45 = 1
     %48 = 0
     %49 = %43
     %44 = 0
  label while4 :
     %47 = %44 < %49
     ifFalse %47 goto endwhile4
     %44 = %44 + %46
     %45 = %45 * %44
     %44 = %44 + %48
     goto while4
  label endwhile4 :
  label exit_if_4 :
     %57 = a < 0
     ifFalse %57 goto else_if_5
     halt "Invalid integer value in math operation."
     goto exit_if_5
  label else_if_5 :
     %53 = 1
     %52 = 1
     %55 = 0
     %56 = a
     %51 = 0
  label while5 :
     %54 = %51 < %56
     ifFalse %54 goto endwhile5
     %51 = %51 + %53
     %52 = %52 * %51
     %51 = %51 + %55
     goto while5
  label endwhile5 :
  label exit_if_5 :
     %58 = %45 * %52
     %60 = float %58
     %59 = %37 <=. %60
     ifFalse %59 goto else_if_9
     ;;; = 'x=A[1]!-b;'
     %61 = 1
     %63 = %61
     %62 = A[%63]
     %70 = %62 < 0
     ifFalse %70 goto else_if_6
     halt "Invalid integer value in math operation."
     goto exit_if_6
  label else_if_6 :
     %66 = 1
     %65 = 1
     %68 = 0
     %69 = %62
     %64 = 0
  label while6 :
     %67 = %64 < %69
     ifFalse %67 goto endwhile6
     %64 = %64 + %66
     %65 = %65 * %64
     %64 = %64 + %68
     goto while6
  label endwhile6 :
  label exit_if_6 :
     %71 = %65 - b
     %72 = float %71
     x = %72
     ;;; = 'A[1]=(b-2)!!;'
     %73 = 1
     %74 = 2
     %75 = b - %74
     %82 = %75 < 0
     ifFalse %82 goto else_if_7
     halt "Invalid integer value in math operation."
     goto exit_if_7
  label else_if_7 :
     %78 = 1
     %77 = 1
     %80 = 0
     %81 = %75
     %76 = 0
  label while7 :
     %79 = %76 < %81
     ifFalse %79 goto endwhile7
     %76 = %76 + %78
     %77 = %77 * %76
     %76 = %76 + %80
     goto while7
  label endwhile7 :
  label exit_if_7 :
     %89 = %77 < 0
     ifFalse %89 goto else_if_8
     halt "Invalid integer value in math operation."
     goto exit_if_8
  label else_if_8 :
     %85 = 1
     %84 = 1
     %87 = 0
     %88 = %77
     %83 = 0
  label while8 :
     %86 = %83 < %88
     ifFalse %86 goto endwhile8
     %83 = %83 + %85
     %84 = %84 * %83
     %83 = %83 + %87
     goto while8
  label endwhile8 :
  label exit_if_8 :
     %90 = %73
     A[%90] = %84
     ;;; = 'write"A[1]=";'
     writes "A[1]="
     ;;; = 'writeA[1];'
     %91 = 1
     %93 = %91
     %92 = A[%93]
     writei %92
     ;;; = 'write"\n";'
     writes "\n"
     goto exit_if_9
  label else_if_9 :
  label exit_if_9 :
     ;;; = 'writea;'
     writei a
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writeb;'
     writei b
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'write"A: ";'
     writes "A: "
     ;;; = 'writeA[0];'
     %94 = 0
     %96 = %94
     %95 = A[%96]
     writei %95
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writeA[1];'
     %97 = 1
     %99 = %97
     %98 = A[%99]
     writei %98
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'writex;'
     writef x
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writey;'
     writef y
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


