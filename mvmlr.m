function b = mvmlr(X,y,int)
%MVMLR -- multiple linear regression
%
%  Usage:
%    b = mvmlr(X,y,int)
%
%  Inputs:
%    X       predictor variables (row oriented matrix)
%    y       response variable (vector)
%    int     0 = no intercept fit (default), 1 = intercept fit
%	     
%  Outputs:  
%    b       regression coefficents
%
%  Description:
%    This function performs an MLR model fit.  To fit an MLR model,
%    the number of samples must be greater than the number of
%    independent variables. If two or more variables describe the
%    same basic phenomenon, the model fit will fail.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvmlr.m,v 1.2 2001/12/04 09:37:11 rune Exp $	

if nargin < 3,
  % default value for int
  int=0;
end

if int == 0,
  % number of samples
  n = length(y);
  % number of variables in X block
  p = size(X,2);
else 
  % number of variables plus intercept
  p = size(X,2) + 1;
  n = length(y);
end

% check to see that n >= number of independent variables
if p>n
  error('More variables than samples, cannot compute!')
end

[a,b] = size(y);

if a < b,
  % make y a column vector
  y = y';
end

if int == 0,
  % fit with no intercept
  b = inv(X'*X)*X'*y;
end

if int == 1,
  %fit with intercept
  X    = [ones(n,1) X]; %add intercept
  b = inv(X'*X)*X'*y;
end

%end of mvmlr
