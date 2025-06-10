function main
  vars
    i integer
    a integer 10
    b float 5
    elemi integer
    elemf float
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10doreadelemi;a[i]=elemi*2;i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'readelemi;'
     readi %4
     elemi = %4
     ;;; = 'a[i]=elemi*2;'
     %5 = 2
     %6 = elemi * %5
     %7 = i
     a[%7] = %6
     ;;; = 'i=i+1;'
     %8 = 1
     %9 = i + %8
     i = %9
     goto while1
  label endwhile1 :
     ;;; = 'foreachelemiinadoi=0;whilei<5dob[i]=1.0/(2*elemi+1);i=i+1;endwhilewriteelemi;write"\n";foreachelemfinbdowrite"  ";writeelemf*3.5;endforwrite"\n";endfor'
     %35 = 1
     %36 = 10
     %10 = 0
  label while4 :
     %34 = %10 < %36
     ifFalse %34 goto endwhile4
     %12 = %10
     %11 = a[%12]
     elemi = %11
     ;;; = 'i=0;'
     %13 = 0
     i = %13
     ;;; = 'whilei<5dob[i]=1.0/(2*elemi+1);i=i+1;endwhile'
  label while2 :
     %14 = 5
     %15 = i < %14
     ifFalse %15 goto endwhile2
     ;;; = 'b[i]=1.0/(2*elemi+1);'
     %16 = 1.0
     %17 = 2
     %18 = %17 * elemi
     %19 = 1
     %20 = %18 + %19
     %22 = float %20
     %21 = %16 /. %22
     %23 = i
     b[%23] = %21
     ;;; = 'i=i+1;'
     %24 = 1
     %25 = i + %24
     i = %25
     goto while2
  label endwhile2 :
     ;;; = 'writeelemi;'
     writei elemi
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'foreachelemfinbdowrite"  ";writeelemf*3.5;endfor'
     %32 = 1
     %33 = 5
     %26 = 0
  label while3 :
     %31 = %26 < %33
     ifFalse %31 goto endwhile3
     %28 = %26
     %27 = b[%28]
     elemf = %27
     ;;; = 'write"  ";'
     writes "  "
     ;;; = 'writeelemf*3.5;'
     %29 = 3.5
     %30 = elemf *. %29
     writef %30
     %26 = %26 + %32
     goto while3
  label endwhile3 :
     ;;; = 'write"\n";'
     writes "\n"
     %10 = %10 + %35
     goto while4
  label endwhile4 :
     return
endfunction


