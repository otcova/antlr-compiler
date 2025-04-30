function f
  params
    a float array
  endparams

   ;;; = 'a[5]=a[5]*10;'
   %1 = a
   %2 = 5
   %3 = 5
   %4 = a
   %5 = %4[%3]
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
   readf %2
   b[%1] = %2
   ;;; = 'c[7]=b[5];'
   %3 = 7
   %4 = 5
   %5 = b[%4]
   c[%3] = %5
   ;;; = 'writeb[5];'
   %6 = 5
   %7 = b[%6]
   writef %7
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'writec[7];'
   %8 = 7
   %9 = c[%8]
   writef %9
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'f(b);'
   %10 = &b
   pushparam %10
   call f
   popparam 
   ;;; = 'writeb[5];'
   %11 = 5
   %12 = b[%11]
   writef %12
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'writec[7];'
   %13 = 7
   %14 = c[%13]
   writef %14
   ;;; = 'write"\n";'
   writes "\n"
   return
endfunction


