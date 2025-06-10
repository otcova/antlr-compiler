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
     ;;; = 'readb;'
     readi %3
     b = %3
     ;;; = 'a=b!/b;'
     %10 = b < 0
     ifFalse %10 goto else_if_1
     halt "Invalid integer value in math operation."
     goto exit_if_1
  label else_if_1 :
     %6 = 1
     %5 = 1
     %8 = 0
     %9 = b
     %4 = 0
  label while1 :
     %7 = %4 < %9
     ifFalse %7 goto endwhile1
     %4 = %4 + %6
     %5 = %5 * %4
     %4 = %4 + %8
     goto while1
  label endwhile1 :
  label exit_if_1 :
     %11 = %5 / b
     a = %11
     ;;; = 'A[0]=8;'
     %12 = 0
     %13 = 8
     %14 = %12
     A[%14] = %13
     ;;; = 'A[1]=9;'
     %15 = 1
     %16 = 9
     %17 = %15
     A[%17] = %16
     ;;; = 'y=a!*x;'
     %24 = a < 0
     ifFalse %24 goto else_if_2
     halt "Invalid integer value in math operation."
     goto exit_if_2
  label else_if_2 :
     %20 = 1
     %19 = 1
     %22 = 0
     %23 = a
     %18 = 0
  label while2 :
     %21 = %18 < %23
     ifFalse %21 goto endwhile2
     %18 = %18 + %20
     %19 = %19 * %18
     %18 = %18 + %22
     goto while2
  label endwhile2 :
  label exit_if_2 :
     %26 = float %19
     %25 = %26 *. x
     y = %25
     ;;; = 'whilex<100doif(-b!+x>(A[0]/2)!*a!)thenx=A[1]!-b;A[1]=(b+1)!!;elsereadx;endifwrite"loop ";writeA[1];write" ";writex;write"\n";endwhile'
  label while9 :
     %27 = 100
     %29 = float %27
     %28 = x <. %29
     ifFalse %28 goto endwhile9
     ;;; = 'if(-b!+x>(A[0]/2)!*a!)thenx=A[1]!-b;A[1]=(b+1)!!;elsereadx;endif'
     %36 = b < 0
     ifFalse %36 goto else_if_3
     halt "Invalid integer value in math operation."
     goto exit_if_3
  label else_if_3 :
     %32 = 1
     %31 = 1
     %34 = 0
     %35 = b
     %30 = 0
  label while3 :
     %33 = %30 < %35
     ifFalse %33 goto endwhile3
     %30 = %30 + %32
     %31 = %31 * %30
     %30 = %30 + %34
     goto while3
  label endwhile3 :
  label exit_if_3 :
     %37 = - %31
     %39 = float %37
     %38 = %39 +. x
     %40 = 0
     %42 = %40
     %41 = A[%42]
     %43 = 2
     %44 = %41 / %43
     %51 = %44 < 0
     ifFalse %51 goto else_if_4
     halt "Invalid integer value in math operation."
     goto exit_if_4
  label else_if_4 :
     %47 = 1
     %46 = 1
     %49 = 0
     %50 = %44
     %45 = 0
  label while4 :
     %48 = %45 < %50
     ifFalse %48 goto endwhile4
     %45 = %45 + %47
     %46 = %46 * %45
     %45 = %45 + %49
     goto while4
  label endwhile4 :
  label exit_if_4 :
     %58 = a < 0
     ifFalse %58 goto else_if_5
     halt "Invalid integer value in math operation."
     goto exit_if_5
  label else_if_5 :
     %54 = 1
     %53 = 1
     %56 = 0
     %57 = a
     %52 = 0
  label while5 :
     %55 = %52 < %57
     ifFalse %55 goto endwhile5
     %52 = %52 + %54
     %53 = %53 * %52
     %52 = %52 + %56
     goto while5
  label endwhile5 :
  label exit_if_5 :
     %59 = %46 * %53
     %61 = float %59
     %60 = %38 <=. %61
     %60 = not %60
     ifFalse %60 goto else_if_9
     ;;; = 'x=A[1]!-b;'
     %62 = 1
     %64 = %62
     %63 = A[%64]
     %71 = %63 < 0
     ifFalse %71 goto else_if_6
     halt "Invalid integer value in math operation."
     goto exit_if_6
  label else_if_6 :
     %67 = 1
     %66 = 1
     %69 = 0
     %70 = %63
     %65 = 0
  label while6 :
     %68 = %65 < %70
     ifFalse %68 goto endwhile6
     %65 = %65 + %67
     %66 = %66 * %65
     %65 = %65 + %69
     goto while6
  label endwhile6 :
  label exit_if_6 :
     %72 = %66 - b
     %73 = float %72
     x = %73
     ;;; = 'A[1]=(b+1)!!;'
     %74 = 1
     %75 = 1
     %76 = b + %75
     %83 = %76 < 0
     ifFalse %83 goto else_if_7
     halt "Invalid integer value in math operation."
     goto exit_if_7
  label else_if_7 :
     %79 = 1
     %78 = 1
     %81 = 0
     %82 = %76
     %77 = 0
  label while7 :
     %80 = %77 < %82
     ifFalse %80 goto endwhile7
     %77 = %77 + %79
     %78 = %78 * %77
     %77 = %77 + %81
     goto while7
  label endwhile7 :
  label exit_if_7 :
     %90 = %78 < 0
     ifFalse %90 goto else_if_8
     halt "Invalid integer value in math operation."
     goto exit_if_8
  label else_if_8 :
     %86 = 1
     %85 = 1
     %88 = 0
     %89 = %78
     %84 = 0
  label while8 :
     %87 = %84 < %89
     ifFalse %87 goto endwhile8
     %84 = %84 + %86
     %85 = %85 * %84
     %84 = %84 + %88
     goto while8
  label endwhile8 :
  label exit_if_8 :
     %91 = %74
     A[%91] = %85
     goto exit_if_9
  label else_if_9 :
     ;;; = 'readx;'
     readf %92
     x = %92
  label exit_if_9 :
     ;;; = 'write"loop ";'
     writes "loop "
     ;;; = 'writeA[1];'
     %93 = 1
     %95 = %93
     %94 = A[%95]
     writei %94
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writex;'
     writef x
     ;;; = 'write"\n";'
     writes "\n"
     goto while9
  label endwhile9 :
     ;;; = 'writeb-12;'
     %96 = 12
     %97 = b - %96
     writei %97
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'a=(b-12)!*5;'
     %98 = 12
     %99 = b - %98
     %106 = %99 < 0
     ifFalse %106 goto else_if_10
     halt "Invalid integer value in math operation."
     goto exit_if_10
  label else_if_10 :
     %102 = 1
     %101 = 1
     %104 = 0
     %105 = %99
     %100 = 0
  label while10 :
     %103 = %100 < %105
     ifFalse %103 goto endwhile10
     %100 = %100 + %102
     %101 = %101 * %100
     %100 = %100 + %104
     goto while10
  label endwhile10 :
  label exit_if_10 :
     %107 = 5
     %108 = %101 * %107
     a = %108
     ;;; = 'write"end ";'
     writes "end "
     ;;; = 'writey;'
     writef y
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


