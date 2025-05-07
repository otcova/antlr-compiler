function main
  vars
    a integer
    b integer
    c integer
  endvars

   ;;; = 'a=13;'
   %1 = 13
   a = %1
   ;;; = 'b=4;'
   %2 = 4
   b = %2
   ;;; = 'c=a%b;'
   %3 = a / b
   %3 = b * %3
   %3 = a - %3
   c = %3
   ;;; = 'writec;'
   writei c
   ;;; = 'write'.';'
   %4 = ''.''
   writec %4
   ;;; = 'write'\n';'
   %5 = ''\n''
   writec %5
   ;;; = 'c=(-a)%b;'
   %6 = - a
   %7 = %6 / b
   %7 = b * %7
   %7 = %6 - %7
   c = %7
   ;;; = 'writec;'
   writei c
   ;;; = 'write'.';'
   %8 = ''.''
   writec %8
   ;;; = 'write'\n';'
   %9 = ''\n''
   writec %9
   ;;; = 'c=a%(-b);'
   %10 = - b
   %11 = a / %10
   %11 = %10 * %11
   %11 = a - %11
   c = %11
   ;;; = 'writec;'
   writei c
   ;;; = 'write'.';'
   %12 = ''.''
   writec %12
   ;;; = 'write'\n';'
   %13 = ''\n''
   writec %13
   ;;; = 'c=(a+3)%b;'
   %14 = 3
   %15 = a + %14
   %16 = %15 / b
   %16 = b * %16
   %16 = %15 - %16
   c = %16
   ;;; = 'writec;'
   writei c
   ;;; = 'write'.';'
   %17 = ''.''
   writec %17
   ;;; = 'write'\n';'
   %18 = ''\n''
   writec %18
   ;;; = 'c=(-a-3)%(-b);'
   %19 = - a
   %20 = 3
   %21 = %19 - %20
   %22 = - b
   %23 = %21 / %22
   %23 = %22 * %23
   %23 = %21 - %23
   c = %23
   ;;; = 'writec;'
   writei c
   ;;; = 'write'.';'
   %24 = ''.''
   writec %24
   ;;; = 'write'\n';'
   %25 = ''\n''
   writec %25
   return
endfunction


