function main
  vars
    i integer
    n integer
    x float
    y float
    A float 10
    B float 10
  endvars

     ;;; = 'n=10;'
     %1 = 10
     n = %1
     ;;; = 'i=0;'
     %2 = 0
     i = %2
     ;;; = 'whilei<ndoA[i]=i*i+1;B[i]=1000-i;i=i+1;endwhile'
  label while1 :
     %3 = i < n
     ifFalse %3 goto endwhile1
     ;;; = 'A[i]=i*i+1;'
     %4 = i * i
     %5 = 1
     %6 = %4 + %5
     %7 = i
     %8 = float %6
     A[%7] = %8
     ;;; = 'B[i]=1000-i;'
     %9 = 1000
     %10 = %9 - i
     %11 = i
     %12 = float %10
     B[%11] = %12
     ;;; = 'i=i+1;'
     %13 = 1
     %14 = i + %13
     i = %14
     goto while1
  label endwhile1 :
     ;;; = 'i=0;'
     %15 = 0
     i = %15
     ;;; = 'whilei<ndowrite"before. A[";writei;write"] = ";writeA[i];write" - B[";writei;write"] = ";writeB[i];write"\n";i=i+1;endwhile'
  label while2 :
     %16 = i < n
     ifFalse %16 goto endwhile2
     ;;; = 'write"before. A[";'
     writes "before. A["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeA[i];'
     %18 = i
     %17 = A[%18]
     writef %17
     ;;; = 'write" - B[";'
     writes " - B["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeB[i];'
     %20 = i
     %19 = B[%20]
     writef %19
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %21 = 1
     %22 = i + %21
     i = %22
     goto while2
  label endwhile2 :
     ;;; = 'swap(A,B);'
     %32 = 1
     %33 = 10
     %23 = 0
  label while3 :
     %31 = %23 < %33
     ifFalse %31 goto endwhile3
     %26 = %23
     %25 = A[%26]
     %24 = %25
     %27 = %23
     %29 = %23
     %28 = B[%29]
     A[%27] = %28
     %30 = %23
     B[%30] = %24
     %23 = %23 + %32
     goto while3
  label endwhile3 :
     ;;; = 'i=0;'
     %34 = 0
     i = %34
     ;;; = 'whilei<ndowrite"after. A[";writei;write"] = ";writeA[i];write" - B[";writei;write"] = ";writeB[i];write"\n";i=i+1;endwhile'
  label while4 :
     %35 = i < n
     ifFalse %35 goto endwhile4
     ;;; = 'write"after. A[";'
     writes "after. A["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeA[i];'
     %37 = i
     %36 = A[%37]
     writef %36
     ;;; = 'write" - B[";'
     writes " - B["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeB[i];'
     %39 = i
     %38 = B[%39]
     writef %38
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %40 = 1
     %41 = i + %40
     i = %41
     goto while4
  label endwhile4 :
     return
endfunction


