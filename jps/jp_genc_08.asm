function main
  vars
    i integer
    j integer
  endvars

     ;;; = 'i=2;'
     %1 = 2
     i = %1
     ;;; = 'switchi*i:case4:write"case value = 4\n";endcasecase0:write"case value = 0\n";endcasecase1:write"case value = 1\n";endcaseendswitch'
     %2 = i * i
     %3 = 4
     %4 = %2 == %3
     ifFalse %4 goto else_if_2
     ;;; = 'write"case value = 4\n";'
     writes "case value = 4\n"
     goto switch_exit_1
     goto exit_if_2
  label else_if_2 :
  label exit_if_2 :
     %5 = 0
     %6 = %2 == %5
     ifFalse %6 goto else_if_3
     ;;; = 'write"case value = 0\n";'
     writes "case value = 0\n"
     goto switch_exit_1
     goto exit_if_3
  label else_if_3 :
  label exit_if_3 :
     %7 = 1
     %8 = %2 == %7
     ifFalse %8 goto else_if_4
     ;;; = 'write"case value = 1\n";'
     writes "case value = 1\n"
     goto switch_exit_1
     goto exit_if_4
  label else_if_4 :
  label exit_if_4 :
  label switch_exit_1 :
     return
endfunction


