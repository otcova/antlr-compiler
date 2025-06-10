function main
  vars
    nz integer
    a integer
    b integer
    i integer
    j integer
    sum float
    A integer 2
    M float 200
  endvars

     ;;; = 'reada;'
     readi %1
     a = %1
     ;;; = 'readb;'
     readi %2
     b = %2
     ;;; = 'i=0;'
     %3 = 0
     i = %3
     ;;; = 'whilei<10doj=0;whilej<20doM[i,j]=a;a=a-b;j=j+1;endwhilei=i+1;endwhile'
  label while2 :
     %4 = 10
     %5 = i < %4
     ifFalse %5 goto endwhile2
     ;;; = 'j=0;'
     %6 = 0
     j = %6
     ;;; = 'whilej<20doM[i,j]=a;a=a-b;j=j+1;endwhile'
  label while1 :
     %7 = 20
     %8 = j < %7
     ifFalse %8 goto endwhile1
     ;;; = 'M[i,j]=a;'
     %9 = i * 20
     %9 = %9 + j
     %10 = %9
     %11 = float a
     M[%10] = %11
     ;;; = 'a=a-b;'
     %12 = a - b
     a = %12
     ;;; = 'j=j+1;'
     %13 = 1
     %14 = j + %13
     j = %14
     goto while1
  label endwhile1 :
     ;;; = 'i=i+1;'
     %15 = 1
     %16 = i + %15
     i = %16
     goto while2
  label endwhile2 :
     ;;; = 'nz=0;'
     %17 = 0
     nz = %17
     ;;; = 'sum=0;'
     %18 = 0
     %19 = float %18
     sum = %19
     ;;; = 'i=0;'
     %20 = 0
     i = %20
     ;;; = 'whilei<10doj=0;whilej<20doifM[i,j]==100thennz=nz+1;endifsum=sum+M[i,j];if(10*i+j)%12==bthenwritesum;write"\n";endifj=j+1;endwhilei=i+1;endwhile'
  label while4 :
     %21 = 10
     %22 = i < %21
     ifFalse %22 goto endwhile4
     ;;; = 'j=0;'
     %23 = 0
     j = %23
     ;;; = 'whilej<20doifM[i,j]==100thennz=nz+1;endifsum=sum+M[i,j];if(10*i+j)%12==bthenwritesum;write"\n";endifj=j+1;endwhile'
  label while3 :
     %24 = 20
     %25 = j < %24
     ifFalse %25 goto endwhile3
     ;;; = 'ifM[i,j]==100thennz=nz+1;endif'
     %26 = i * 20
     %26 = %26 + j
     %27 = i < 10
     %28 = 0 <= i
     %27 = %27 and %28
     %28 = j < 20
     %27 = %27 and %28
     %28 = 0 <= j
     %27 = %27 and %28
     ifFalse %27 goto else_if_1
     goto exit_if_1
  label else_if_1 :
     halt "Container index out of range."
  label exit_if_1 :
     %30 = %26
     %29 = M[%30]
     %31 = 100
     %33 = float %31
     %32 = %29 ==. %33
     ifFalse %32 goto else_if_2
     ;;; = 'nz=nz+1;'
     %34 = 1
     %35 = nz + %34
     nz = %35
     goto exit_if_2
  label else_if_2 :
  label exit_if_2 :
     ;;; = 'sum=sum+M[i,j];'
     %36 = i * 20
     %36 = %36 + j
     %37 = i < 10
     %38 = 0 <= i
     %37 = %37 and %38
     %38 = j < 20
     %37 = %37 and %38
     %38 = 0 <= j
     %37 = %37 and %38
     ifFalse %37 goto else_if_3
     goto exit_if_3
  label else_if_3 :
     halt "Container index out of range."
  label exit_if_3 :
     %40 = %36
     %39 = M[%40]
     %41 = sum +. %39
     sum = %41
     ;;; = 'if(10*i+j)%12==bthenwritesum;write"\n";endif'
     %42 = 10
     %43 = %42 * i
     %44 = %43 + j
     %45 = 12
     %46 = %44 / %45
     %46 = %45 * %46
     %46 = %44 - %46
     %47 = %46 == b
     ifFalse %47 goto else_if_4
     ;;; = 'writesum;'
     writef sum
     ;;; = 'write"\n";'
     writes "\n"
     goto exit_if_4
  label else_if_4 :
  label exit_if_4 :
     ;;; = 'j=j+1;'
     %48 = 1
     %49 = j + %48
     j = %49
     goto while3
  label endwhile3 :
     ;;; = 'i=i+1;'
     %50 = 1
     %51 = i + %50
     i = %51
     goto while4
  label endwhile4 :
     ;;; = 'A[0]=nz;'
     %52 = 0
     %53 = %52
     A[%53] = nz
     ;;; = 'A[1]=23;'
     %54 = 1
     %55 = 23
     %56 = %54
     A[%56] = %55
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
     %57 = 0
     %59 = %57
     %58 = A[%59]
     writei %58
     ;;; = 'write",";'
     writes ","
     ;;; = 'writeA[1];'
     %60 = 1
     %62 = %60
     %61 = A[%62]
     writei %61
     ;;; = 'write"]\n";'
     writes "]\n"
     return
endfunction


