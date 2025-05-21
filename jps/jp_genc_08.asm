function main
  vars
    i integer
    j integer
  endvars

   ;;; = 'i=2;'
   %1 = 2
   i = %1
   ;;; = 'switchi*i:case4:write"case value = 4\n";endcasecase0:write"case value = 0\n";endcasecase1:write"case value = 1\n";endcaseendswitch'
   ;;; = 'write"case value = 4\n";'
   writes "case value = 4\n"
   return
endfunction


