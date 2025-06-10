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
     a[i] = %6
     ;;; = 'i=i+1;'
     %7 = 1
     %8 = i + %7
     i = %8
     goto while1
  label endwhile1 :
     ;;; = 'foreachelemiinadoi=0;whilei<5dob[i]=1.0/(2*elemi+1);i=i+1;endwhilewriteelemi;write"\n";foreachelemfinbdowrite"  ";writeelemf*3.5;endforwrite"\n";endfor'
     %31 = 1
     %32 = 10
     %9 = 0
  label while4 :
     %30 = %9 < %32
     ifFalse %30 goto endwhile4
     %10 = a[%9]
     elemi = %10
     ;;; = 'i=0;'
     %11 = 0
     i = %11
     ;;; = 'whilei<5dob[i]=1.0/(2*elemi+1);i=i+1;endwhile'
  label while2 :
     %12 = 5
     %13 = i < %12
     ifFalse %13 goto endwhile2
     ;;; = 'b[i]=1.0/(2*elemi+1);'
     %14 = 1.0
     %15 = 2
     %16 = %15 * elemi
     %17 = 1
     %18 = %16 + %17
     %20 = float %18
     %19 = %14 /. %20
     b[i] = %19
     ;;; = 'i=i+1;'
     %21 = 1
     %22 = i + %21
     i = %22
     goto while2
  label endwhile2 :
     ;;; = 'writeelemi;'
     writei elemi
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'foreachelemfinbdowrite"  ";writeelemf*3.5;endfor'
     %28 = 1
     %29 = 5
     %23 = 0
  label while3 :
     %27 = %23 < %29
     ifFalse %27 goto endwhile3
     %24 = b[%23]
     elemf = %24
     ;;; = 'write"  ";'
     writes "  "
     ;;; = 'writeelemf*3.5;'
     %25 = 3.5
     %26 = elemf *. %25
     writef %26
     %23 = %23 + %28
     goto while3
  label endwhile3 :
     ;;; = 'write"\n";'
     writes "\n"
     %9 = %9 + %31
     goto while4
  label endwhile4 :
     return
endfunction


