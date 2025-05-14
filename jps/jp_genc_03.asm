function main
  vars
    i integer
    j integer
    c1 character
    c2 character
    x float
    y float
    Ai integer 10
    Af float 10
  endvars

   ;;; = 'x=55;'
   %1 = 55
   %2 = float %1
   x = %2
   ;;; = 'y=99;'
   %3 = 99
   %4 = float %3
   y = %4
   ;;; = 'swap(x,y);'
   %5 = x
   x = y
   y = %5
   ;;; = 'writex;'
   writef x
   ;;; = 'write" ";'
   writes " "
   ;;; = 'writey;'
   writef y
   ;;; = 'write"\n";'
   writes "\n"
   return
endfunction


