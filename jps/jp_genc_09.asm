function main
  vars
    i integer
    j integer
    M float 150
    K float 150
    t float
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10doj=0;whilej<15doreadM[i,j];j=j+1;endwhilei=i+1;endwhile'
  label while2 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile2
     ;;; = 'j=0;'
     %4 = 0
     j = %4
     ;;; = 'whilej<15doreadM[i,j];j=j+1;endwhile'
  label while1 :
     %5 = 15
     %6 = j < %5
     ifFalse %6 goto endwhile1
     ;;; = 'readM[i,j];'
     %7 = i * 15
     %7 = %7 + j
     readf %8
     %9 = %7
     M[%9] = %8
     ;;; = 'j=j+1;'
     %10 = 1
     %11 = j + %10
     j = %11
     goto while1
  label endwhile1 :
     ;;; = 'i=i+1;'
     %12 = 1
     %13 = i + %12
     i = %13
     goto while2
  label endwhile2 :
     ;;; = 'K=M;'
     %19 = 1
     %20 = 150
     %14 = 0
  label while3 :
     %18 = %14 < %20
     ifFalse %18 goto endwhile3
     %16 = %14
     %15 = M[%16]
     %17 = %14
     K[%17] = %15
     %14 = %14 + %19
     goto while3
  label endwhile3 :
     ;;; = 'i=3;'
     %21 = 3
     i = %21
     ;;; = 'whilei<7doj=3;whilej<idot=K[i,j];K[i,j]=K[j,i];K[j,i]=t;j=j+1;endwhilei=i+1;endwhile'
  label while5 :
     %22 = 7
     %23 = i < %22
     ifFalse %23 goto endwhile5
     ;;; = 'j=3;'
     %24 = 3
     j = %24
     ;;; = 'whilej<idot=K[i,j];K[i,j]=K[j,i];K[j,i]=t;j=j+1;endwhile'
  label while4 :
     %25 = j < i
     ifFalse %25 goto endwhile4
     ;;; = 't=K[i,j];'
     %26 = i * 15
     %26 = %26 + j
     %27 = i < 10
     %28 = 0 <= i
     %27 = %27 and %28
     %28 = j < 15
     %27 = %27 and %28
     %28 = 0 <= j
     %27 = %27 and %28
     ifFalse %27 goto else_if_1
     goto exit_if_1
  label else_if_1 :
     halt "Container index out of range."
  label exit_if_1 :
     %30 = %26
     %29 = K[%30]
     t = %29
     ;;; = 'K[i,j]=K[j,i];'
     %31 = i * 15
     %31 = %31 + j
     %32 = j * 15
     %32 = %32 + i
     %33 = j < 10
     %34 = 0 <= j
     %33 = %33 and %34
     %34 = i < 15
     %33 = %33 and %34
     %34 = 0 <= i
     %33 = %33 and %34
     ifFalse %33 goto else_if_2
     goto exit_if_2
  label else_if_2 :
     halt "Container index out of range."
  label exit_if_2 :
     %36 = %32
     %35 = K[%36]
     %37 = %31
     K[%37] = %35
     ;;; = 'K[j,i]=t;'
     %38 = j * 15
     %38 = %38 + i
     %39 = %38
     K[%39] = t
     ;;; = 'j=j+1;'
     %40 = 1
     %41 = j + %40
     j = %41
     goto while4
  label endwhile4 :
     ;;; = 'i=i+1;'
     %42 = 1
     %43 = i + %42
     i = %43
     goto while5
  label endwhile5 :
     ;;; = 'i=0;'
     %44 = 0
     i = %44
     ;;; = 'whilei<10doj=0;whilej<15dowriteK[i,j];write" ";j=j+1;endwhilewrite"\n";i=i+1;endwhile'
  label while7 :
     %45 = 10
     %46 = i < %45
     ifFalse %46 goto endwhile7
     ;;; = 'j=0;'
     %47 = 0
     j = %47
     ;;; = 'whilej<15dowriteK[i,j];write" ";j=j+1;endwhile'
  label while6 :
     %48 = 15
     %49 = j < %48
     ifFalse %49 goto endwhile6
     ;;; = 'writeK[i,j];'
     %50 = i * 15
     %50 = %50 + j
     %51 = i < 10
     %52 = 0 <= i
     %51 = %51 and %52
     %52 = j < 15
     %51 = %51 and %52
     %52 = 0 <= j
     %51 = %51 and %52
     ifFalse %51 goto else_if_3
     goto exit_if_3
  label else_if_3 :
     halt "Container index out of range."
  label exit_if_3 :
     %54 = %50
     %53 = K[%54]
     writef %53
     ;;; = 'write" ";'
     writes " "
     ;;; = 'j=j+1;'
     %55 = 1
     %56 = j + %55
     j = %56
     goto while6
  label endwhile6 :
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %57 = 1
     %58 = i + %57
     i = %58
     goto while7
  label endwhile7 :
     return
endfunction


