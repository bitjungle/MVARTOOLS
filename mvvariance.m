function [xvar] = mvvariance(X)
%MVVARIANCE -- finds the variance of each column in a matrix
%
%  Usage:
%    [xvar] = mvvariance(X) 
%
%  Inputs:
%    X       is the input data matrix or vector
%
%  Outputs:
%    xvar    is a row vector containing the variances
%
%  Description:
%
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvvariance.m,v 1.2 2001/12/04 10:17:16 rune Exp $	

if (nargin ~= 1), % wrong number of input arguments
  error('Wrong number of input arguments! Usage: mvvar(X)');
  break;
end

[m, n] = size (X);

%	                   1               _ 2
%	Equation: Var(X)= --- * sum( (xi - x) )
%	                  m-1   
%

if ((m == 1) | (n == 1)), % its a vector
  m = length(X);
  xvar = (1/(m-1))*sum(mvcenter(X).^2);
else                      % its a matrix
  xvar = (1/(m-1))*sum(mvcenter(X).^2);
end

% end of mvvariance