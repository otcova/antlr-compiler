function f1
  params
    a integer
    b integer
  endparams

  vars
    c float
    d integer
    found boolean
  endvars

     ;;; = 'found=false;'
     %1 = 0
     found = %1
     ;;; = 'c=a+0.7;'
     %2 = 0.7
     %4 = float a
     %3 = %4 +. %2
     c = %3
     ;;; = 'd=0;'
     %5 = 0
     d = %5
     ;;; = 'ifa+d>cornotfoundthenwhileb>0dob=b-1;found=true;endwhileendif'
     %6 = a + d
     %8 = float %6
     %7 = %8 <=. c
     %7 = not %7
     %9 = not found
     %10 = %7 or %9
     ifFalse %10 goto endif1
     ;;; = 'whileb>0dob=b-1;found=true;endwhile'
  label while1 :
     %11 = 0
     %12 = b <= %11
     %12 = not %12
     ifFalse %12 goto endwhile1
     ;;; = 'b=b-1;'
     %13 = 1
     %14 = b - %13
     b = %14
     ;;; = 'found=true;'
     %15 = 1
     found = %15
     goto while1
  label endwhile1 :
  label endif1 :
     ;;; = 'ifb<=11thenc=2*c+1;endif'
     %16 = 11
     %17 = b <= %16
     ifFalse %17 goto endif2
     ;;; = 'c=2*c+1;'
     %18 = 2
     %20 = float %18
     %19 = %20 *. c
     %21 = 1
     %23 = float %21
     %22 = %19 +. %23
     c = %22
  label endif2 :
     ;;; = 'writec;'
     writef c
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction

function main
  vars
    a integer
    b integer
  endvars

   ;;; = 'a=4;'
   %1 = 4
   a = %1
   ;;; = 'b=2*a+1;'
   %2 = 2
   %3 = %2 * a
   %4 = 1
   %5 = %3 + %4
   b = %5
   ;;; = 'f1(b,3+b);'
   pushparam b
   %6 = 3
   %7 = %6 + b
   pushparam %7
   call f1
   popparam 
   popparam 
   return
endfunction


