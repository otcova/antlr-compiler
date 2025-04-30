function prod_escalar
  params
    _result integer
    a1 integer array
    a2 integer array
  endparams

  vars
    i integer
    s integer
  endvars

     ;;; = 's=0;'
     %1 = 0
     s = %1
     ;;; = 'whilei<10dos=s+a1[i]*a2[i];i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 's=s+a1[i]*a2[i];'
     %4 = a1
     %5 = %4[i]
     %6 = a2
     %7 = %6[i]
     %8 = %5 * %7
     %9 = s + %8
     s = %9
     ;;; = 'i=i+1;'
     %10 = 1
     %11 = i + %10
     i = %11
     goto while1
  label endwhile1 :
     ;;; = 'returns;'
     _result = s
     return
     return
endfunction

function main
  vars
    i integer
    v1 integer 10
    v2 integer 10
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10dov1[i]=-i;v2[i]=i*i;i=i+1;endwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'v1[i]=-i;'
     %4 = - i
     v1[i] = %4
     ;;; = 'v2[i]=i*i;'
     %5 = i * i
     v2[i] = %5
     ;;; = 'i=i+1;'
     %6 = 1
     %7 = i + %6
     i = %7
     goto while1
  label endwhile1 :
     ;;; = 'writeprod_escalar(v1,v2);'
     pushparam 
     %8 = &v1
     pushparam %8
     %9 = &v2
     pushparam %9
     call prod_escalar
     popparam 
     popparam 
     popparam %10
     writei %10
     ;;; = 'write"\n";'
     writes "\n"
     return
endfunction


