function [ypred] = mvpredict(X,b,lv,b0)
%MVPREDICT -- predict y-values from multivariate model
%
%  Usage:
%    [ypred] = mvpredict(X,b,lv,b0)
%
%  Inputs:
%    X       predictor variables
%    b       regression coefficients
%    lv      number of latent variables to use
%    b0      mean y from calibration data (optional)
%	     
%  Outputs:  
%    ypred   predicted response values
%
%  Description:
%    Predict response values from multivariate model.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvpredict.m,v 1.2 2001/12/04 09:47:48 rune Exp $	

[m,n] = size(X);
[p,q] = size(b);

if q ~= n,
  error('X and b must have same length!')
end

if lv > p,
  error(['Max number of latent variables: ' num2str(p)])
end

if nargin < 4,
  b0 = 0;
end

% predicting values
ypred = b0 + X*b(lv,:)';

%end of mvpredict
