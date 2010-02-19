function [press,cumpress,rmsep,pred] = mvtestval(X,y,b,lv,my)
%MVTESTVAL -- test-set validation of multivariate model
%
%  Usage:
%    [press,cumpress,rmsep,pred] = mvtestval(X,y,b,lv,my)
%
%  Inputs:
%    X         scaled/preprocessed predictor variables
%    y         reference measurements (vector)
%    b         regression coefficients matrix
%    maxlv     max number of latent variables to use (optional)
%    my        mean value of y-vector (if mean centered, optional)
%
%  Outputs:  
%    press     prediction residual error sum of squares
%    cumpress  cumulative prediction residual error sum of squares
%    rmsep     root mean square error of prediction
%    pred      predicted values
%
%  Description:
%    Test-set validation of multivariate model.  For more model
%    statistics, use 'mvpmstats'. See also the validation functions:
%    'mvcvbyclass' and 'mvtestval'.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvtestval.m,v 1.2 2001/12/04 10:16:12 rune Exp $	

[rb,cb] = size(b);
[rx,cx] = size(X);

if nargin < 5,
  my = 0;
end

% if no value is given for lv, calculate for all factors in b
if (nargin < 4) | (isempty(b) == 1),
  lv = rb;
end

% initializing variables
pred  = zeros(rx,lv);
press = zeros(rx,lv);

for f = 1:lv,
  % predicting values
  pred(:,f) = mvpredict(X,b,f);

  % rescaling
  pred(:,f) = mvrecenter(pred(:,f),my);
  
  % prediction error
  press(:,f)   = (pred(:,f) - y).^2;
end

% statistics
cumpress = sum(press,1);
rmsep    = sqrt(cumpress/rx);

%end of mvtestval

