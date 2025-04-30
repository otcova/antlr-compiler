function mul
  params
    _result integer
    a integer
    b integer
  endparams

   ;;; = 'returna*b;'
   %1 = a * b
   _result = %1
   return
   return
endfunction

function main
  vars
    x integer
    y integer
  endvars

   ;;; = 'readx;'
   readi %1
   x = %1
   ;;; = 'ready;'
   readi %2
   y = %2
   ;;; = 'write"x*y*2=";'
   writes "x*y*2="
   ;;; = 'writemul(x,y)*2;'
   pushparam 
   pushparam x
   pushparam y
   call mul
   popparam 
   popparam 
   popparam %3
   %4 = 2
   %5 = %3 * %4
   writei %5
   ;;; = 'write".\n";'
   writes ".\n"
   return
endfunction


