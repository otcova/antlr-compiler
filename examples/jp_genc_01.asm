function main
  vars
    a integer
    b integer
    end boolean
    pi float
  endvars

   ;;; = 'a=12;'
   %1 = 12
   a = %1
   ;;; = 'b=a*5+a*(a+1);'
   %2 = 5
   %3 = a * %2
   %4 = 1
   %5 = a + %4
   %6 = a * %5
   %7 = %3 + %6
   b = %7
   ;;; = 'end=b>=aandnot(a==0);'
   %8 = b < a
   %8 = not %8
   %9 = 0
   %10 = a == %9
   %11 = not %10
   %12 = %8 and %11
   end = %12
   ;;; = 'pi=3.3+1/a--2.0/a;'
   %13 = 3.3
   %14 = 1
   %15 = %14 / a
   %17 = float %15
   %16 = %13 +. %17
   %18 = 2.0
   %19 = -. %18
   %21 = float a
   %20 = %19 /. %21
   %22 = %16 -. %20
   pi = %22
   ;;; = 'writea==borend;'
   %23 = a == b
   %24 = %23 or end
   writei %24
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'writea*b;'
   %25 = a * b
   writei %25
   ;;; = 'write"\n";'
   writes "\n"
   ;;; = 'write2*pi;'
   %26 = 2
   %28 = float %26
   %27 = %28 *. pi
   writef %27
   ;;; = 'write"\n";'
   writes "\n"
   return
endfunction


