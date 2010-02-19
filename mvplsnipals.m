function [b,p,q,w,t,u,inner,X,y] = mvplsnipals(X,y,maxlv)
%MVPLSNIPALS -- Partial Least Squares Regression using NIPALS
%	
%  Usage:
%    [b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(X,y,maxlv)
%	
%  Inputs:
%    X        calibration data X matrix
%    y        calibration data y vector (or matrix for PLS2)
%    maxlv    number of latent variables to calculate (optional)
%
%  Outputs:
%    b        regression coefficients
%    p        X loadings
%    q        y loadings (=ones(1,lv) for PLS1)
%    w        loading weights
%    t        X scores
%    u        y scores
%    inner    vector containing the inner (X/y scores) relationships
%    Xres     X residuals
%    yres     y residuals
%
%  Description:

%    Partial Least Squares Regression (PLSR) using the NIPALS
%    algoritm.  For later predictions, do e.g: 
%    >> ypred = mvpredict(newX,b,3) 
%    if you want to use three latent variables in your model. The
%    function will do PLS2 if there are more than one column in Y.

%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvplsnipals.m,v 1.4 2001/12/04 08:50:47 rune Exp $	

if abs(max(mean(X))) > 1e3*eps,
  % Is the X matrix mean centered? If not, issue a warning!
  warning('Input matrix is not mean centered! Please consider doing this!');
end

% size of X matrix
[mx,nx] = size(X);

% size of y 
[my,ny] = size(y);

if mx ~= my,
  error('X and y must have same number of observations!')
end

% how many latent variables to calculate?
if nargin == 3, 
  lv = min([maxlv,nx]); 
else 
  lv = nx; 
end

% do a rank check to estimate the number of linearly
% independent rows or columns of X
rx = rank(X);
if rx < lv,
  disp('Low rank!');
  disp(['Will only calculate ' int2str(rx) ' latent variables!'])
  lv = rx;
end

% initializing variables
b     = zeros(lv,nx);
p     = zeros(nx,lv);
q     = ones(ny,lv);
w     = zeros(nx,lv);
t     = zeros(mx,lv);
u     = zeros(mx,lv);
inner = zeros(1,lv);

for h = 1:lv,% for each latent variable, do:
  [p(:,h),q(:,h),w(:,h),t(:,h),u(:,h),inner(h),X,y] = mvplsnipcore(X,y);
end

% calculate regression coefficients
b = mvplsregcoeff(p,q,w,inner);
