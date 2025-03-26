func main()
  var b : array [10] of int
  var a : array [6] of float
  var i,j: int
  var x : float
  var c : array [9] of char

  z = x+1;
  x[k] = 3;
  
  b = {1,2,3,4,5,6,7,8,9,10};
  b = {i+1}^5;
  b = {1,2,3,4,
       'a','b','c','d',
       j>0,x+1};

  a = {1.1, 2.2, 3.3,
       4.4, 5.5, 6.6};
  a = {1.1, 2.2, 3.3}^2;
  a = {true, x>0, i<10}^4;
  a = {j+1}^6;
  a = {'h'}^3;
  a = {'h','i','j','k'};
  a = {'h','i','j','k','l','m'};

  i = 0;
  while i<10 do
     write i;  write " ";
     write a[i]; write "\n";
     j = i-2*a[j];
  endwhile
  
  c = {'a'}^9;
  c = {'a','b','c'}^3;
  c = {'a','b',x}^3;
  c = {'a','b','c'}^4;

  if i*j then
     x = x+y;
     a[x] = 1;
  endif

  b = {a}^2;
  b = {c}^10;
endfunc
