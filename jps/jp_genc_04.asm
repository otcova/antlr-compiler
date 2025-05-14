function main
  vars
    i integer
    j integer
    k integer
    n integer
    c1 character
    c2 character
    x float
    y float
    Ai integer 10
    Af float 10
  endvars

     ;;; = 'n=10;'
     %1 = 10
     n = %1
     ;;; = 'i=0;'
     %2 = 0
     i = %2
     ;;; = 'whilei<ndoAi[i]=i*i+1;i=i+1;endwhile'
  label while1 :
     %3 = i < n
     ifFalse %3 goto endwhile1
     ;;; = 'Ai[i]=i*i+1;'
     %4 = i * i
     %5 = 1
     %6 = %4 + %5
     Ai[i] = %6
     ;;; = 'i=i+1;'
     %7 = 1
     %8 = i + %7
     i = %8
     goto while1
  label endwhile1 :
     ;;; = 'readk;'
     readi %9
     k = %9
     ;;; = 'j=5;'
     %10 = 5
     j = %10
     ;;; = 'swap(k,Ai[j+1]);'
     %11 = 1
     %12 = j + %11
     %13 = Ai[%12]
     %14 = k
     k = %13
     Ai[%12] = %14
     ;;; = 'write"A. ";'
     writes "A. "
     ;;; = 'writek;'
     writei k
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writeAi[j+1];'
     %15 = 1
     %16 = j + %15
     %17 = Ai[%16]
     writei %17
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'swap(Ai[0],Ai[n-1]);'
     %18 = 0
     %19 = 1
     %20 = n - %19
     %21 = Ai[%18]
     %22 = Ai[%20]
     %23 = %21
     Ai[%18] = %22
     Ai[%20] = %23
     ;;; = 'write"B. ";'
     writes "B. "
     ;;; = 'writeAi[0];'
     %24 = 0
     %25 = Ai[%24]
     writei %25
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writeAi[n-1];'
     %26 = 1
     %27 = n - %26
     %28 = Ai[%27]
     writei %28
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'swap(Ai[0],k);'
     %29 = 0
     %30 = Ai[%29]
     %31 = %30
     Ai[%29] = k
     k = %31
     ;;; = 'write"C. ";'
     writes "C. "
     ;;; = 'writeAi[0];'
     %32 = 0
     %33 = Ai[%32]
     writei %33
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=0;'
     %34 = 0
     i = %34
     ;;; = 'whilei<ndowrite"Ai[";writei;write"] = ";writeAi[i];write"\n";i=i+1;endwhile'
  label while2 :
     %35 = i < n
     ifFalse %35 goto endwhile2
     ;;; = 'write"Ai[";'
     writes "Ai["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeAi[i];'
     %36 = Ai[i]
     writei %36
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %37 = 1
     %38 = i + %37
     i = %38
     goto while2
  label endwhile2 :
     return
endfunction


