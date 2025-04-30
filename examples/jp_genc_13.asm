function read_chars
  params
    _result integer
    a character array
  endparams

  vars
    i integer
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'whilei<10doreada[i];ifa[i]!='.'theni=i+1;elsereturni;endifendwhile'
  label while1 :
     %2 = 10
     %3 = i < %2
     ifFalse %3 goto endwhile1
     ;;; = 'reada[i];'
     %4 = a
     readc %5
     %4[i] = %5
     ;;; = 'ifa[i]!='.'theni=i+1;elsereturni;endif'
     %6 = a
     %7 = %6[i]
     %8 = '.'
     %9 = %7 == %8
     %9 = not %9
     ifFalse %9 goto else2
     ;;; = 'i=i+1;'
     %10 = 1
     %11 = i + %10
     i = %11
     goto endif1
  label else2 :
     ;;; = 'returni;'
     _result = i
     return
  label endif1 :
     goto while1
  label endwhile1 :
     ;;; = 'return10;'
     %12 = 10
     _result = %12
     return
     return
endfunction

function find_vowels
  params
    n integer
    vc character array
    vb boolean array
  endparams

  vars
    c character
  endvars

     ;;; = 'whilen>0doc=vc[n-1];vb[n-1]=c=='a'orc=='e'orc=='i'orc=='o'orc=='u';n=n-1;endwhile'
  label while1 :
     %1 = 0
     %2 = n <= %1
     %2 = not %2
     ifFalse %2 goto endwhile1
     ;;; = 'c=vc[n-1];'
     %3 = 1
     %4 = n - %3
     %5 = vc
     %6 = %5[%4]
     c = %6
     ;;; = 'vb[n-1]=c=='a'orc=='e'orc=='i'orc=='o'orc=='u';'
     %7 = vb
     %8 = 1
     %9 = n - %8
     %10 = 'a'
     %11 = c == %10
     %12 = 'e'
     %13 = c == %12
     %14 = %11 or %13
     %15 = 'i'
     %16 = c == %15
     %17 = %14 or %16
     %18 = 'o'
     %19 = c == %18
     %20 = %17 or %19
     %21 = 'u'
     %22 = c == %21
     %23 = %20 or %22
     %7[%9] = %23
     ;;; = 'n=n-1;'
     %24 = 1
     %25 = n - %24
     n = %25
     goto while1
  label endwhile1 :
     return
endfunction

function write_consonants
  params
    _result float
    n integer
    vc character array
    vb boolean array
  endparams

  vars
    k float
    i integer
  endvars

     ;;; = 'i=0;'
     %1 = 0
     i = %1
     ;;; = 'k=0;'
     %2 = 0
     %3 = float %2
     k = %3
     ;;; = 'whilei!=ndoifvb[i]thenk=k+1;elsewritevc[i];endifi=i+1;endwhile'
  label while1 :
     %4 = i == n
     %4 = not %4
     ifFalse %4 goto endwhile1
     ;;; = 'ifvb[i]thenk=k+1;elsewritevc[i];endif'
     %5 = vb
     %6 = %5[i]
     ifFalse %6 goto else2
     ;;; = 'k=k+1;'
     %7 = 1
     %9 = float %7
     %8 = k +. %9
     k = %8
     goto endif1
  label else2 :
     ;;; = 'writevc[i];'
     %10 = vc
     %11 = %10[i]
     writec %11
  label endif1 :
     ;;; = 'i=i+1;'
     %12 = 1
     %13 = i + %12
     i = %13
     goto while1
  label endwhile1 :
     ;;; = 'write'\n';'
     %14 = '\n'
     writec %14
     ;;; = 'return100*k/n;'
     %15 = 100
     %17 = float %15
     %16 = %17 *. k
     %19 = float n
     %18 = %16 /. %19
     _result = %18
     return
     return
endfunction

function main
  vars
    a character 10
    b boolean 10
    n integer
    p float
  endvars

   ;;; = 'n=read_chars(a);'
   pushparam 
   %1 = &a
   pushparam %1
   call read_chars
   popparam 
   popparam %2
   n = %2
   ;;; = 'find_vowels(n,a,b);'
   pushparam n
   %3 = &a
   pushparam %3
   %4 = &b
   pushparam %4
   call find_vowels
   popparam 
   popparam 
   popparam 
   ;;; = 'p=write_consonants(n,a,b);'
   pushparam 
   pushparam n
   %5 = &a
   pushparam %5
   %6 = &b
   pushparam %6
   call write_consonants
   popparam 
   popparam 
   popparam 
   popparam %7
   p = %7
   ;;; = 'writep;'
   writef p
   ;;; = 'write"\n";'
   writes "\n"
   return
endfunction


