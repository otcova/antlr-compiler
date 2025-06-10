function main
  vars
    i integer
    x float
    a integer 10
    b float 5
    elemi integer
    elemf float
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10doreadx;b[i/2]=x*2;a[i]=i;i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'readx;'
     readf %4
     x = %4
     ;;; = 'b[i/2]=x*2;'
     %5 = 2
     %6 = i / %5
     %7 = 2
     %9 = float %7
     %8 = x *. %9
     %10 = %6
     b[%10] = %8
     ;;; = 'a[i]=i;'
     %11 = i
     a[%11] = i
     ;;; = 'i=i+1;'
     %12 = 1
     %13 = i + %12
     i = %13
     goto while1
  label endwhile1 :
     ;;; = 'foreachelemfinadowriteelemf;write"\n";foreachxinbdowrite"  ";writeelemf-x/3.5;endforwrite"\n";endfor'
     %28 = 1
     %29 = 10
     %14 = 0
  label while3 :
     %27 = %14 < %29
     ifFalse %27 goto endwhile3
     %16 = %14
     %15 = a[%16]
     %17 = float %15
     elemf = %17
     ;;; = 'writeelemf;'
     writef elemf
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'foreachxinbdowrite"  ";writeelemf-x/3.5;endfor'
     %25 = 1
     %26 = 5
     %18 = 0
  label while2 :
     %24 = %18 < %26
     ifFalse %24 goto endwhile2
     %20 = %18
     %19 = b[%20]
     x = %19
     ;;; = 'write"  ";'
     writes "  "
     ;;; = 'writeelemf-x/3.5;'
     %21 = 3.5
     %22 = x /. %21
     %23 = elemf -. %22
     writef %23
     %18 = %18 + %25
     goto while2
  label endwhile2 :
     ;;; = 'write"\n";'
     writes "\n"
     %14 = %14 + %28
     goto while3
  label endwhile3 :
     return
endfunction


