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
   readi x
   ;;; = 'ready;'
   readi y
   ;;; = 'write"x*y*2=";'
   writes "x*y*2="
   ;;; = 'writemul(x,y)*2;'
   pushparam 
   pushparam x
   pushparam y
   call mul
   popparam 
   popparam 
   popparam %1
   %2 = 2
   %3 = %1 * %2
   writei %3
   ;;; = 'write".\n";'
   writes ".\n"
   return
endfunction


