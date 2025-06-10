function main
  vars
    i integer
    j integer
    M float 150
    t float
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10doj=0;whilej<15doM[i,j]=i+j;j=j+1;endwhilei=i+1;endwhile'
  label while2 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile2
     ;;; = 'j=0;'
     %4 = 0
     j = %4
     ;;; = 'whilej<15doM[i,j]=i+j;j=j+1;endwhile'
  label while1 :
     %5 = 15
     %6 = j < %5
     ifFalse %6 goto endwhile1
     ;;; = 'M[i,j]=i+j;'
     %7 = i * 15
     %7 = %7 + j
     %8 = i + j
     %9 = %7
     %10 = float %8
     M[%9] = %10
     ;;; = 'j=j+1;'
     %11 = 1
     %12 = j + %11
     j = %12
     goto while1
  label endwhile1 :
     ;;; = 'i=i+1;'
     %13 = 1
     %14 = i + %13
     i = %14
     goto while2
  label endwhile2 :
     ;;; = 'i=0;'
     %15 = 0
     i = %15
     ;;; = 'whilei<15doj=0;whilej<10dowriteM[i,j];write" ";j=j+1;endwhilewrite"\n";i=i+1;endwhile'
  label while4 :
     %16 = 15
     %17 = i < %16
     ifFalse %17 goto endwhile4
     ;;; = 'j=0;'
     %18 = 0
     j = %18
     ;;; = 'whilej<10dowriteM[i,j];write" ";j=j+1;endwhile'
  label while3 :
     %19 = 10
     %20 = j < %19
     ifFalse %20 goto endwhile3
     ;;; = 'writeM[i,j];'
     %21 = i * 15
     %21 = %21 + j
     %22 = i < 10
     %23 = 0 <= i
     %22 = %22 and %23
     %23 = j < 15
     %22 = %22 and %23
     %23 = 0 <= j
     %22 = %22 and %23
     ifFalse %22 goto else_if_1
     goto exit_if_1
  label else_if_1 :
     halt "Container index out of range."
  label exit_if_1 :
     %25 = %21
     %24 = M[%25]
     writef %24
     ;;; = 'write" ";'
     writes " "
     ;;; = 'j=j+1;'
     %26 = 1
     %27 = j + %26
     j = %27
     goto while3
  label endwhile3 :
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


