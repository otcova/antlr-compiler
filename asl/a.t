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
   %8 = b < a
   %8 = not %8
   %9 = 0
   %10 = a == %9
   %11 = %8 and %10
   end = %11
   %12 = 3.3
   %13 = 1
   %14 = %13 / a
   %15 = %12 +. %14
   %16 = 2.0
   %17 = %16 / a
   %18 = %15 -. %17
   pi = %18
   %19 = a == b
   %20 = %19 or end
   writei %20
   writes "\n"
   %21 = a * b
   writei %21
   writes "\n"
   %22 = 2
   %23 = %22 *. pi
   writef %23
   writes "\n"
   return
endfunction


