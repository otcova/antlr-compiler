function main
  vars
    a integer
    b integer
    end boolean
    pi float
  endvars

   %1 = 12
   a = %1
   %2 = 5
   %3 = a * %2
   %4 = 1
   %5 = a + %4
   %6 = a * %5
   %7 = %3 + %6
   b = %7
   %9 = 0
   %10 = a == %9
   end = %10
   %11 = 3.3
   %12 = 1
   %13 = %12 / a
   %14 = %11 +. %13
   %15 = 2.0
   %16 = %15 / a
   %17 = %14 -. %16
   pi = %17
   writei end
   writes "\n"
   %19 = a * b
   writei %19
   writes "\n"
   %20 = 2
   %21 = %20 *. pi
   writef %21
   writes "\n"
   return
endfunction


