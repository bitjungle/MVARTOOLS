function [b,p,w,t,u,inner,Xres,yres] = mvrpls(X,y,p0,t0,inner0,maxlv,mem)
%MVRPLS -- Recursive Partial Least Squares regression
%	
%  Usage:
%    [b,p,w,t,u,inner,Xres,yres] = mvrpls(X,y,p0,t0,inner0,maxlv,mem)
%	
%  Inputs:
%    X        calibration data X matrix
%    y        calibration data y vector
%    maxlv    number of latent variables to calculate (optional)
%    p0       X loadings
%    t0       X scores
%    inner0   vector containing the inner (X/y scores) relationships
%    maxlv    max number of latent variables to calculate
%    mem      forgetting factor (optional, default = 1)
%
%  Outputs:
%    b        regression coefficients
%    p        X loadings
%    w        loading weights
%    t        X scores
%    u        y scores
%    inner    vector containing the inner (X/y scores) relationships
%    Xres     X residuals
%    yres     y residuals
%
%  Description:
%    Recursive Partial Least Squares regression, reference:
%    K. Helland, Ph.D. Thesis, 1993. See also 'mvrplsc' and
%    'mvrplsc'. 
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvrpls.m,v 1.3 2001/12/05 14:57:39 rune Exp $	

[my,ny] = size(y);

if ny > 1,
  error('This function only works with one y!')
end

if (~exist('mem')==1),
  mem = 1;
end

% Create representation of data based on loadings and new X and y
L = diag(sqrt(diag(t0'*t0)));
R = p0*L;
S = inner0*L;

% Create new calibration set
Xnew = [mem*R';X];
ynew = [mem*S';y];

% Calibration
warning off % we don't want all those warnings about centering
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xnew,ynew,maxlv);
warning on  % turn the warnings back on again

% end of file