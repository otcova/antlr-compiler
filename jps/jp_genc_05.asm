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
     %7 = float %6
     A[i] = %7
     ;;; = 'B[i]=1000-i;'
     %8 = 1000
     %9 = %8 - i
     %10 = float %9
     B[i] = %10
     ;;; = 'i=i+1;'
     %11 = 1
     %12 = i + %11
     i = %12
     goto while1
  label endwhile1 :
     ;;; = 'i=0;'
     %13 = 0
     i = %13
     ;;; = 'whilei<ndowrite"before. A[";writei;write"] = ";writeA[i];write" - B[";writei;write"] = ";writeB[i];write"\n";i=i+1;endwhile'
  label while2 :
     %14 = i < n
     ifFalse %14 goto endwhile2
     ;;; = 'write"before. A[";'
     writes "before. A["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeA[i];'
     %15 = A[i]
     writef %15
     ;;; = 'write" - B[";'
     writes " - B["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeB[i];'
     %16 = B[i]
     writef %16
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %17 = 1
     %18 = i + %17
     i = %18
     goto while2
  label endwhile2 :
     ;;; = 'swap(A,B);'
     %19 = 0
  label while3 :
     %23 = %19 < 10
     ifFalse %23 goto endwhile3
     %20 = A[%19]
     %21 = B[%19]
     %22 = %20
     A[%19] = %21
     B[%19] = %22
     %19 = %19 + 1
     goto while3
  label endwhile3 :
     ;;; = 'i=0;'
     %24 = 0
     i = %24
     ;;; = 'whilei<ndowrite"after. A[";writei;write"] = ";writeA[i];write" - B[";writei;write"] = ";writeB[i];write"\n";i=i+1;endwhile'
  label while4 :
     %25 = i < n
     ifFalse %25 goto endwhile4
     ;;; = 'write"after. A[";'
     writes "after. A["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeA[i];'
     %26 = A[i]
     writef %26
     ;;; = 'write" - B[";'
     writes " - B["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeB[i];'
     %27 = B[i]
     writef %27
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %28 = 1
     %29 = i + %28
     i = %29
     goto while4
  label endwhile4 :
     return
endfunction


