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
     b[%6] = %8
     ;;; = 'a[i]=i;'
     a[i] = i
     ;;; = 'i=i+1;'
     %10 = 1
     %11 = i + %10
     i = %11
     goto while1
  label endwhile1 :
     ;;; = 'foreachelemfinadowriteelemf;write"\n";foreachxinbdowrite"  ";writeelemf-x/3.5;endforwrite"\n";endfor'
     %24 = 1
     %25 = 10
     %12 = 0
  label while3 :
     %23 = %12 < %25
     ifFalse %23 goto endwhile3
     %13 = a[%12]
     %14 = float %13
     elemf = %14
     ;;; = 'writeelemf;'
     writef elemf
     ;;; = 'write"\n";'
     writes "\n"
     ;;; = 'foreachxinbdowrite"  ";writeelemf-x/3.5;endfor'
     %21 = 1
     %22 = 5
     %15 = 0
  label while2 :
     %20 = %15 < %22
     ifFalse %20 goto endwhile2
     %16 = b[%15]
     x = %16
     ;;; = 'write"  ";'
     writes "  "
     ;;; = 'writeelemf-x/3.5;'
     %17 = 3.5
     %18 = x /. %17
     %19 = elemf -. %18
     writef %19
     %15 = %15 + %21
     goto while2
  label endwhile2 :
     ;;; = 'write"\n";'
     writes "\n"
     %12 = %12 + %24
     goto while3
  label endwhile3 :
     return
endfunction


