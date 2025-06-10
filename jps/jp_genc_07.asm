function main
  vars
    nz integer
    i integer
    j integer
    sum float
    A integer 2
    M float 200
  endvars

     ;;; = 'nz=0;'
     %1 = 0
     nz = %1
     ;;; = 'sum=0;'
     %2 = 0
     %3 = float %2
     sum = %3
     ;;; = 'i=0;'
     %4 = 0
     i = %4
     ;;; = 'whilei<10doj=0;whilej<20doifM[i,j]==0thennz=nz+1;endifsum=sum+M[i,j];if(10*i+j)%12==0thenwritenz;write"\n";endifj=j+1;endwhilei=i+1;endwhile'
  label while2 :
     %5 = 10
     %6 = i < %5
     ifFalse %6 goto endwhile2
     ;;; = 'j=0;'
     %7 = 0
     j = %7
     ;;; = 'whilej<20doifM[i,j]==0thennz=nz+1;endifsum=sum+M[i,j];if(10*i+j)%12==0thenwritenz;write"\n";endifj=j+1;endwhile'
  label while1 :
     %8 = 20
     %9 = j < %8
     ifFalse %9 goto endwhile1
     ;;; = 'ifM[i,j]==0thennz=nz+1;endif'
     %10 = i * 20
     %10 = %10 + j
     %11 = i < 10
     %12 = 0 <= i
     %11 = %11 and %12
     %12 = j < 20
     %11 = %11 and %12
     %12 = 0 <= j
     %11 = %11 and %12
     ifFalse %11 goto else_if_1
     goto exit_if_1
  label else_if_1 :
     halt "Container index out of range."
  label exit_if_1 :
     %14 = %10
     %13 = M[%14]
     %15 = 0
     %17 = float %15
     %16 = %13 ==. %17
     ifFalse %16 goto else_if_2
     ;;; = 'nz=nz+1;'
     %18 = 1
     %19 = nz + %18
     nz = %19
     goto exit_if_2
  label else_if_2 :
  label exit_if_2 :
     ;;; = 'sum=sum+M[i,j];'
     %20 = i * 20
     %20 = %20 + j
     %21 = i < 10
     %22 = 0 <= i
     %21 = %21 and %22
     %22 = j < 20
     %21 = %21 and %22
     %22 = 0 <= j
     %21 = %21 and %22
     ifFalse %21 goto else_if_3
     goto exit_if_3
  label else_if_3 :
     halt "Container index out of range."
  label exit_if_3 :
     %24 = %20
     %23 = M[%24]
     %25 = sum +. %23
     sum = %25
     ;;; = 'if(10*i+j)%12==0thenwritenz;write"\n";endif'
     %26 = 10
     %27 = %26 * i
     %28 = %27 + j
     %29 = 12
     %30 = %28 / %29
     %30 = %29 * %30
     %30 = %28 - %30
     %31 = 0
     %32 = %30 == %31
     ifFalse %32 goto else_if_4
     ;;; = 'writenz;'
     writei nz
     ;;; = 'write"\n";'
     writes "\n"
     goto exit_if_4
  label else_if_4 :
  label exit_if_4 :
     ;;; = 'j=j+1;'
     %33 = 1
     %34 = j + %33
     j = %34
     goto while1
  label endwhile1 :
     ;;; = 'i=i+1;'
     %35 = 1
     %36 = i + %35
     i = %36
     goto while2
  label endwhile2 :
     ;;; = 'A[0]=nz;'
     %37 = 0
     %38 = %37
     A[%38] = nz
     ;;; = 'A[1]=23;'
     %39 = 1
     %40 = 23
     %41 = %39
     A[%41] = %40
     ;;; = 'write"nz=";'
     writes "nz="
     ;;; = 'writenz;'
     writei nz
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'write"sum=";'
     writes "sum="
     ;;; = 'writesum;'
     writef sum
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'write"A: [";'
     writes "A: ["
     ;;; = 'writeA[0];'
     %42 = 0
     %44 = %42
     %43 = A[%44]
     writei %43
     ;;; = 'write",";'
     writes ","
     ;;; = 'writeA[1];'
     %45 = 1
     %47 = %45
     %46 = A[%47]
     writei %46
     ;;; = 'write"]\n";'
     writes "]\n"
     return
endfunction


