func f(x: int)
   var b : array [5] of bool
   try
      b[1] = x-1;
      throw b[x-2];
   catch
      b : write "error";
      b[5] : write "crash";
   endtry
   
   return x*2;
endfunc

func main()
   var i,j : int
   var x,y,z : float
   var a : array [10] of float

   try
      i = 0;
      if a then
         if y+1 then
	   throw a + b[0];
 	 else
            a[x] = z/y;
	    throw k;
         endif
      endif
      if a[0]>a[j-2]*y then
         throw (x>0 or y)!=z+1;
      else
         if x[i]!=z+1 then
            throw f;
         endif
      endif  
   catch
      'a'   : a[0]=a[9]-k*z;
              x=0;
      2*j+1 : i=1;
              if a[i-w*2]!=2 then
 	         x = 1;
	      endif
      'Z'   : write "ok";
   endtry
endfunc
