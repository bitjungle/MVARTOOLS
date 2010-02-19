function [optlv] = mvoptlv(rmse)
%MVOPTLV -- find optimal number of latent variables
%
%  Usage:
%    [optlv] = mvoptlv(rmse)
%
%  Inputs:
%    rmse    root mean error of (calibration|validation|prediction)
%
%  Outputs:
%    optlv   optimal number of latent variables
%
%  Description:
%    Simple heuristic to find optimal number of latent variables
%    for a multivariate calibration model.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvoptlv.m,v 1.2 2001/12/04 09:41:22 rune Exp $	

[m,n] = size(rmse);

if min(m,n) > 1,
  error('input must be a vector!')
end

% find global minima
[gminval,gmin] = min(rmse);

% find all local minima
lmin = find(diff(rmse)>1e-5);

% continue with a local minima if it is to the left
% of the global minima
optlv=min([gmin lmin]);

% the current optimal lv must give an improvement of 
% at least x% over it's left neighbor
x = 5;
while optlv > 1,
  tmp = x*rmse(optlv-1)/100;
  if rmse(optlv) > (rmse(optlv-1)-tmp),
    optlv = optlv-1;
  else
    break;
  end
end
