function one
  params
    _result float
  endparams

   ;;; = 'return+1;'
   %1 = 1
   _result = %1
   return
   return
endfunction

function sort
  params
    v float array
  endparams

  vars
    i integer
    j integer
    jmin integer
    aux float
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<20-1dojmin=i;j=i+1;whilej<20doifv[j]<v[jmin]thenjmin=j;endifj=j+1;endwhileifjmin!=ithenaux=v[i];v[i]=v[jmin];v[jmin]=aux;endifi=i+1;endwhile'
  label while2 :
     %2 = 20
     %3 = 1
     %4 = %2 - %3
     %5 = i < %4
     ifFalse %5 goto endwhile2
     ;;; = 'jmin=i;'
     jmin = i
     ;;; = 'j=i+1;'
     %6 = 1
     %7 = i + %6
     j = %7
     ;;; = 'whilej<20doifv[j]<v[jmin]thenjmin=j;endifj=j+1;endwhile'
  label while1 :
     %8 = 20
     %9 = j < %8
     ifFalse %9 goto endwhile1
     ;;; = 'ifv[j]<v[jmin]thenjmin=j;endif'
     %10 = v
     %11 = %10[j]
     %12 = v
     %13 = %12[jmin]
     %14 = %11 <. %13
     ifFalse %14 goto endif1
     ;;; = 'jmin=j;'
     jmin = j
  label endif1 :
     ;;; = 'j=j+1;'
     %15 = 1
     %16 = j + %15
     j = %16
     goto while1
  label endwhile1 :
     ;;; = 'ifjmin!=ithenaux=v[i];v[i]=v[jmin];v[jmin]=aux;endif'
     %17 = jmin == i
     %17 = not %17
     ifFalse %17 goto endif2
     ;;; = 'aux=v[i];'
     %18 = v
     %19 = %18[i]
     aux = %19
     ;;; = 'v[i]=v[jmin];'
     %20 = v
     %21 = v
     %22 = %21[jmin]
     %20[i] = %22
     ;;; = 'v[jmin]=aux;'
     %23 = v
     %23[jmin] = aux
  label endif2 :
     ;;; = 'i=i+1;'
     %24 = 1
     %25 = i + %24
     i = %25
     goto while2
  label endwhile2 :
     return
endfunction

function evenPositivesAndSort
  params
    v float array
  endparams

  vars
    i integer
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<20doifv[i]>0thenv[i]=one();endifi=i+1;endwhile'
  label while1 :
     %2 = 20
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'ifv[i]>0thenv[i]=one();endif'
     %4 = v
     %5 = %4[i]
     %6 = 0
     %8 = float %6
     %7 = %5 <=. %8
     %7 = not %7
     ifFalse %7 goto endif1
     ;;; = 'v[i]=one();'
     %9 = v
     pushparam 
     call one
     popparam %10
     %9[i] = %10
  label endif1 :
     ;;; = 'i=i+1;'
     %11 = 1
     %12 = i + %11
     i = %12
     goto while1
  label endwhile1 :
     ;;; = 'sort(v);'
     %13 = &v
     pushparam %13
     call sort
     popparam 
     return
endfunction

function main
  vars
    af float 20
    i integer
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<20doreadaf[i];i=i+1;endwhile'
  label while1 :
     %2 = 20
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'readaf[i];'
     readf %4
     af[i] = %4
     ;;; = 'i=i+1;'
     %5 = 1
     %6 = i + %5
     i = %6
     goto while1
  label endwhile1 :
     ;;; = 'evenPositivesAndSort(af);'
     %7 = &af
     pushparam %7
     call evenPositivesAndSort
     popparam 
     ;;; = 'i=0;'
     %8 = 0
     i = %8
     ;;; = 'whilei<20doifaf[i]!=one()thenwriteaf[i];write' ';i=i+1;elsewrite'\n';return;endifendwhile'
  label while2 :
     %9 = 20
     %10 = i < %9
     ifFalse %10 goto endwhile2
     ;;; = 'ifaf[i]!=one()thenwriteaf[i];write' ';i=i+1;elsewrite'\n';return;endif'
     %11 = af[i]
     pushparam 
     call one
     popparam %12
     %13 = %11 ==. %12
     %13 = not %13
     ifFalse %13 goto else2
     ;;; = 'writeaf[i];'
     %14 = af[i]
     writef %14
     ;;; = 'write' ';'
     %15 = ' '
     writec %15
     ;;; = 'i=i+1;'
     %16 = 1
     %17 = i + %16
     i = %17
     goto endif1
  label else2 :
     ;;; = 'write'\n';'
     %18 = '\n'
     writec %18
     ;;; = 'return;'
  label endif1 :
     goto while2
  label endwhile2 :
     ;;; = 'write'\n';'
     %19 = '\n'
     writec %19
     return
endfunction


