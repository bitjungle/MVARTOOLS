function [x] = mvdigfilt(u,a)
%MVDIGFILT -- 1st order digital filter
%
%  Usage:
%    [x] = mvdigfilt(u,a)
%  
%  Inputs:
%    u        is the input data vector
%
%  Outputs:
%    x        is the filtered output data
%  
%  Description:
%    Simple 1st order digital filter
%  
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvdigfilt.m,v 1.2 2001/12/04 09:28:57 rune Exp $	

[r,c] = size(u);

if min([r c])~=1,
  error('Input u must be a vector');
end

if (a<0) | (a>1),
  error('a must be in the interval [0,1]');
end

obj = max([r c]);

x = zeros(r,c);

for k = 1:obj,
  if k == 1,
    x(1) = u(1);
  else
    x(k) = a*x(k-1) + (1-a)*u(k);
  end
end

% end of mvdigfilt