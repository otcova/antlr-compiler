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
     %7 = i
     Ai[%7] = %6
     ;;; = 'i=i+1;'
     %8 = 1
     %9 = i + %8
     i = %9
     goto while1
  label endwhile1 :
     ;;; = 'readk;'
     readi %10
     k = %10
     ;;; = 'j=5;'
     %11 = 5
     j = %11
     ;;; = 'swap(k,Ai[j+1]);'
     %12 = 1
     %13 = j + %12
     %14 = k
     %16 = %13
     %15 = Ai[%16]
     k = %15
     %17 = %13
     Ai[%17] = %14
     ;;; = 'write"A. ";'
     writes "A. "
     ;;; = 'writek;'
     writei k
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writeAi[j+1];'
     %18 = 1
     %19 = j + %18
     %21 = %19
     %20 = Ai[%21]
     writei %20
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'swap(Ai[0],Ai[n-1]);'
     %22 = 0
     %23 = 1
     %24 = n - %23
     %27 = %22
     %26 = Ai[%27]
     %25 = %26
     %28 = %22
     %30 = %24
     %29 = Ai[%30]
     Ai[%28] = %29
     %31 = %24
     Ai[%31] = %25
     ;;; = 'write"B. ";'
     writes "B. "
     ;;; = 'writeAi[0];'
     %32 = 0
     %34 = %32
     %33 = Ai[%34]
     writei %33
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writeAi[n-1];'
     %35 = 1
     %36 = n - %35
     %38 = %36
     %37 = Ai[%38]
     writei %37
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'swap(Ai[0],k);'
     %39 = 0
     %42 = %39
     %41 = Ai[%42]
     %40 = %41
     %43 = %39
     Ai[%43] = k
     k = %40
     ;;; = 'write"C. ";'
     writes "C. "
     ;;; = 'writeAi[0];'
     %44 = 0
     %46 = %44
     %45 = Ai[%46]
     writei %45
     ;;; = 'write" ";'
     writes " "
     ;;; = 'writek;'
     writei k
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=0;'
     %47 = 0
     i = %47
     ;;; = 'whilei<ndowrite"Ai[";writei;write"] = ";writeAi[i];write"\n";i=i+1;endwhile'
  label while2 :
     %48 = i < n
     ifFalse %48 goto endwhile2
     ;;; = 'write"Ai[";'
     writes "Ai["
     ;;; = 'writei;'
     writei i
     ;;; = 'write"] = ";'
     writes "] = "
     ;;; = 'writeAi[i];'
     %50 = i
     %49 = Ai[%50]
     writei %49
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'i=i+1;'
     %51 = 1
     %52 = i + %51
     i = %52
     goto while2
  label endwhile2 :
     return
endfunction


