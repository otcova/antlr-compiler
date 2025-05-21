function main
  vars
    i integer
    j integer
  endvars

   ;;; = 'readi;'
   readi %1
   i = %1
   ;;; = 'switchi*i:case1:write"case value = 1\n";endcasecase4:write"case value = 4\n";endcasecase9:write"case value = 9\n";endcasecase16:write"case value = 16\n";endcasecase9:write"case value = 9 err!\n";endcaseendswitch'
   ;;; = 'write"case value = 1\n";'
   writes "case value = 1\n"
   ;;; = 'switchi:case33:i=33;endcaseendswitch'
   ;;; = 'i=33;'
   %2 = 33
   i = %2
   ;;; = 'writei;'
   writei i
   ;;; = 'write"\n";'
   writes "\n"
   return
endfunction


