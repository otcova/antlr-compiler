function main
  vars
    i integer
    j integer
  endvars

     ;;; = 'readi;'
     readi %1
     i = %1
     ;;; = 'switchi*i:case1:write"case value = 1\n";endcasecase4:write"case value = 4\n";endcasecase9:write"case value = 9\n";endcasecase16:write"case value = 16\n";endcasecase9:write"case value = 9 err!\n";endcaseendswitch'
     %2 = i * i
     %3 = 1
     %4 = %2 == %3
     ifFalse %4 goto else_if_2
     ;;; = 'write"case value = 1\n";'
     writes "case value = 1\n"
     goto switch_exit_1
     goto exit_if_2
  label else_if_2 :
  label exit_if_2 :
     %5 = 4
     %6 = %2 == %5
     ifFalse %6 goto else_if_3
     ;;; = 'write"case value = 4\n";'
     writes "case value = 4\n"
     goto switch_exit_1
     goto exit_if_3
  label else_if_3 :
  label exit_if_3 :
     %7 = 9
     %8 = %2 == %7
     ifFalse %8 goto else_if_4
     ;;; = 'write"case value = 9\n";'
     writes "case value = 9\n"
     goto switch_exit_1
     goto exit_if_4
  label else_if_4 :
  label exit_if_4 :
     %9 = 16
     %10 = %2 == %9
     ifFalse %10 goto else_if_5
     ;;; = 'write"case value = 16\n";'
     writes "case value = 16\n"
     goto switch_exit_1
     goto exit_if_5
  label else_if_5 :
  label exit_if_5 :
     %11 = 9
     %12 = %2 == %11
     ifFalse %12 goto else_if_6
     ;;; = 'write"case value = 9 err!\n";'
     writes "case value = 9 err!\n"
     goto switch_exit_1
     goto exit_if_6
  label else_if_6 :
  label exit_if_6 :
  label switch_exit_1 :
     ;;; = 'switchi:case33:i=33;endcaseendswitch'
     %13 = 33
     %15 = i == %13
     ifFalse %15 goto else_if_8
     ;;; = 'i=33;'
     %14 = 33
     i = %14
     goto switch_exit_7
     goto exit_if_8
  label else_if_8 :
  label exit_if_8 :
  label switch_exit_7 :
     ;;; = 'writei;'
     writei i
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


