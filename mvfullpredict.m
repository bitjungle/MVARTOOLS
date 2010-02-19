function [ypred,t,Xres] = mvfullpredict(X,W,P,inner,lv,q,b0,xmean)
%MVFULLPREDICT -- predict y-values from PLS loading weights
%
%  Usage:
%    [ypred,t,Xres] = mvfullpredict(X,W,P,inner,lv,q,b0,xmean)
%
%  Inputs:
%    X       predictor variables
%    W       PLS loading weights
%    P       PLS X loadings
%    inner   vector containing the inner (X/y scores) relationships
%    lv      number of latent variables to use
%    q       PLS y loadings (NOT SUPPORTED YET!)
%    b0      mean y from calibration data (optional)
%    xmean   mean x from calibration data (optional)
%	     
%  Outputs:  
%    ypred   predicted response values
%    t       PLS scores
%    Xres    X residuals
%
%  Description:
%    Predict response values from multivariate model using loading
%    weights. Centering of input data is done if 'xmean' is provided.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvfullpredict.m,v 1.4 2001/12/05 10:05:03 rune Exp $	

[m,n] = size(X);
[p,q] = size(W);

if (p ~= n),
  error('X and W must have same length (rows in W = columns in X)!')
end

if lv > p,
  error(['Max number of latent variables: ' num2str(p)])
end

if (~exist('b0') | isempty(b0)),
  b0 = 0;
end

if exist('xmean'), % center x-data?
  X = mvcenter(X,xmean);
end

t = zeros(m,lv);
ypred = ones(m,1)*b0;
Xres = X;

for i=1:lv,
  % calculate scores
  t(:,i) = Xres*W(:,i);

  % compute residuals
  Xres = Xres - t(:,i)*P(:,i)';

  % do predictions
  ypred = ypred + inner(i)*t(:,i);
end

%end of mvfullpredict