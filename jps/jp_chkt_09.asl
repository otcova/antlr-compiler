func ff(a: array [10] of int,
        b: array [6] of float): float
   var i,j : int

   a = {1,2,3,4}:{5,6,7}:{8,9,10};
   a = {1,2,3}^2:{4,5.1,6,7};
   a = {1,2,3}^2:{4,5.1};

   b = {i+j}^2:{i*2.1,j/b[1]}^2;
   b = {i+j}^2:{i,j}^2;
   b = {i+j}^2:{i,z};

   return b[1]+j<0;
endfunc

func main()
  var x : array [10] of int
  var y : array [6] of float
  var i,j: int
  var x : float
  var c : array [9] of char

  y[0] = ff(x,y);

  z = x+1;
  x[k] = 3;  

  i = 0;
  while i<10 do
     write i;  write " ";
     write a[i]; write "\n";
     j = i-2*a[j];
  endwhile

  if i*j then
     x = x+y;
     a[x] = 1;
  endif

  b = {true,a}^2;
  b = {c}^10;
endfunc
