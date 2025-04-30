function f
  params
    _result boolean
    a integer
    f float
  endparams

  vars
    x integer
    b boolean
    z integer 10
  endvars

     ;;; = 'readz[5];'
     %1 = 5
     readi %2
     z[%1] = %2
     ;;; = 'writez[5]-88*f;'
     %3 = 5
     %4 = z[%3]
     %5 = 88
     %7 = float %5
     %6 = %7 *. f
     %9 = float %4
     %8 = %9 -. %6
     writef %8
     ;;; = 'readb;'
     readi %10
     b = %10
     ;;; = 'readf;'
     readf %11
     f = %11
     ;;; = 'ifbthenwrite"h\n\tl\\a";write---f;write"\n";endif'
     ifFalse b goto endif1
     ;;; = 'write"h\n\tl\\a";'
     writes "h\n\tl\\a"
     ;;; = 'write---f;'
     %12 = -. f
     %13 = -. %12
     %14 = -. %13
     writef %14
     ;;; = 'write"\n";'
     writes "\n"
  label endif1 :
     ;;; = 'returntrue;'
     %15 = 1
     _result = %15
     return
     return
endfunction

function fz
  params
    _result float
    r integer
    u float
  endparams

     ;;; = 'whiler>0.01dor=r-1;endwhile'
  label while1 :
     %1 = 0.01
     %3 = float r
     %2 = %3 <=. %1
     %2 = not %2
     ifFalse %2 goto endwhile1
     ;;; = 'r=r-1;'
     %4 = 1
     %5 = r - %4
     r = %5
     goto while1
  label endwhile1 :
     ;;; = 'ifr==0thenf(55555,-5/4);endif'
     %6 = 0
     %7 = r == %6
     ifFalse %7 goto endif1
     ;;; = 'f(55555,-5/4);'
     pushparam 
     %8 = 55555
     pushparam %8
     %9 = 5
     %10 = - %9
     %11 = 4
     %12 = %10 / %11
     %13 = float %12
     pushparam %13
     call f
     popparam 
     popparam 
     popparam 
  label endif1 :
     ;;; = 'return(r+3)*u;'
     %14 = 3
     %15 = r + %14
     %17 = float %15
     %16 = %17 *. u
     _result = %16
     return
     return
endfunction

function main
  vars
    a integer
    q float
  endvars

   ;;; = 'q=-1;'
   %1 = 1
   %2 = - %1
   %3 = float %2
   q = %3
   ;;; = 'q=fz(3+4,fz(4444,q+3));'
   pushparam 
   %4 = 3
   %5 = 4
   %6 = %4 + %5
   pushparam %6
   pushparam 
   %7 = 4444
   pushparam %7
   %8 = 3
   %10 = float %8
   %9 = q +. %10
   pushparam %9
   call fz
   popparam 
   popparam 
   popparam %11
   pushparam %11
   call fz
   popparam 
   popparam 
   popparam %12
   q = %12
   ;;; = 'writeq+3.7+4;'
   %13 = 3.7
   %14 = q +. %13
   %15 = 4
   %17 = float %15
   %16 = %14 +. %17
   writef %16
   ;;; = 'write"\n";'
   writes "\n"
   return
endfunction


