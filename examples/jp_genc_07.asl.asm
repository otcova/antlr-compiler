function f
  params
    a float array
  endparams

   ;;; = 'a[5]=a[5]*10;'
   %1 = a
   %2 = 5
   %3 = a
   %4 = 5
   %5 = %3[%4]
   %6 = 10
   %8 = float %6
   %7 = %5 *. %8
   %1[%2] = %7
   return
endfunction

function main
  vars
    b float 10
    c float 10
  endvars

   ;;; = 'readb[5];'
   %1 = 5
   readf b
   b[%1] = b
   ;;; = 'c[7]=b[5];'
   %2 = 7
   %3 = 5
   %4 = b[%3]
   c[%2] = %4
   ;;; = 'writeb[5];'
   %5 = 5
   %6 = b[%5]
   writef %6
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'writec[7];'
   %7 = 7
   %8 = c[%7]
   writef %8
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'f(b);'
   %9 = &b
   pushparam %9
   call f
   popparam 
   ;;; = 'writeb[5];'
   %10 = 5
   %11 = b[%10]
   writef %11
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'writec[7];'
   %12 = 7
   %13 = c[%12]
   writef %13
   ;;; = 'write"\n";'
   writes "\n"
   return
endfunction


