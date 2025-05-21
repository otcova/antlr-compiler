function main
  vars
    i integer
    j integer
  endvars

     ;;; = 'i=1;'
     %1 = 1
     i = %1
     ;;; = 'whilei<4dowrite"i=";writei;write"    i*i=";writei*i;switchi*i:case0:write"    case value = 0\n";endcasecase1:write"    case value = 1\n";endcasecase4:write"    case value = 4\n";endcasedefault:write"    case default\n";endswitchi=i+1;endwhile'
  label while1 :
     %2 = 4
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'write"i=";'
     writes "i="
     ;;; = 'writei;'
     writei i
     ;;; = 'write"    i*i=";'
     writes "    i*i="
     ;;; = 'writei*i;'
     %4 = i * i
     writei %4
     ;;; = 'switchi*i:case0:write"    case value = 0\n";endcasecase1:write"    case value = 1\n";endcasecase4:write"    case value = 4\n";endcasedefault:write"    case default\n";endswitch'
     %5 = i * i
     %6 = 0
     %7 = %5 == %6
     ifFalse %7 goto else_if_2
     ;;; = 'write"    case value = 0\n";'
     writes "    case value = 0\n"
     goto switch_exit_1
     goto exit_if_2
  label else_if_2 :
  label exit_if_2 :
     %8 = 1
     %9 = %5 == %8
     ifFalse %9 goto else_if_3
     ;;; = 'write"    case value = 1\n";'
     writes "    case value = 1\n"
     goto switch_exit_1
     goto exit_if_3
  label else_if_3 :
  label exit_if_3 :
     %10 = 4
     %11 = %5 == %10
     ifFalse %11 goto else_if_4
     ;;; = 'write"    case value = 4\n";'
     writes "    case value = 4\n"
     goto switch_exit_1
     goto exit_if_4
  label else_if_4 :
  label exit_if_4 :
     ;;; = 'write"    case default\n";'
     writes "    case default\n"
  label switch_exit_1 :
     ;;; = 'i=i+1;'
     %12 = 1
     %13 = i + %12
     i = %13
     goto while1
  label endwhile1 :
     return
endfunction


