function [p,q,w,t,u,inner,X,y] = mvplsnipcore(X,y)
%MVPLSNIPCORE -- PLS NIPALS core
%	
%  Usage:
%    [p,q,w,t,u,inner,Xres,yres] = mvplsnipcore(X,y)
%	
%  Inputs:
%    X        calibration data X matrix
%    y        calibration data y vector (or matrix for PLS2)
%
%  Outputs:
%    p        X loadings
%    q        y loadings (for PLS2)
%    w        loading weights
%    t        X scores
%    u        y scores
%    inner    vector containing the inner (X/y scores) relationships
%    Xres     X residuals
%    yres     y residuals
%
%  Description:
%    Core of the PLS NIPALS algorithm. Calculates first latent
%    variable for the X/y input. Called by mvplsnipals, which
%    is the preferred function to use for most people. This
%    function will NOT check if the input is valid (e.g. whether
%    number of rows in X and y are equal, etc.). This function is
%    an expert tool, using e.g. mvplsnipals will properly check 
%    your input.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvplsnipcore.m,v 1.2 2001/12/04 08:47:02 rune Exp $	

% size of X and y
[rx,cx] = size(X);
[ry,cy] = size(y);

% initializing variables
p     = zeros(cx,1);
w     = zeros(cx,1);
t     = ones(rx,1);  % filling t with ones to make it pass the while-statement
told  = zeros(rx,1); % filling told with zeros to make it pass the while-statement
if cy == 1,
  q = 1;
  u = y;
else
  [yvarmax,yvarmaxcol]=max(mvvariance(y)); % column in y with the highest variance
  u = y(:,yvarmaxcol);                     % y scores start value
end

% max number of iterations to do
maxit = 100;
itnum = 1;

% convergence criterium
convcrit = 1e3*eps;

while ((sum(abs(told-t))) > convcrit) & (itnum < maxit),
  % counting number of iterations
  itnum = itnum + 1;
  % copy previousely calculated t to told
  told = t;
  % calculate X weighting vector
  w  = (u'*X)'; % which is the same as w  = X'*u (but faster)
  % scale to unit length
  w  =  w / sqrt(w'*w);
  % calculate X scores
  t  = X*w;
  if cy > 1, % don't bother if we only have one y
    % y loadings
    q = (t'*y)';
    % scale to unit length
    q  =  q / sqrt((q'*q));
    % calculate new weighting scores
    u  = y*q;    
  end
end

% X loadings
p = ((t'*X) / (t'*t))';
% calculate scaling factor
pnorm = sqrt(p'*p);
% rescale X weights
w = w*pnorm;
% rescale X scores
t = t*pnorm;
% rescale X loadings
p = p / pnorm;
% the inner product for this lv (relation between X and y scores)
inner = (u'*t) / (t'*t);
% calculate residuals
X = X - (t*p');
y = y - inner*t*q';
