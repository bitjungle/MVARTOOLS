function [md,m,C] = mvmdist(X,m,C)
%MVMDIST -- mahalanobis distance
%
%  Usage: 
%    [md,m,C] = mvmdist(X,m,C)
%
%  Inputs:
%    X      unknow sample data
%    m      model mean (optional)
%    C      model variance-covariance matrix (optional)
%
%  Outputs:
%    md     Mahalanobis distance from model data
%    m      model mean
%    C      model variance-covariance matrix
%
%  Description:
%    Returns Mahalanobis distance between the multivariate samples X
%    and the mean of the input samples, or (optionally) from the mean
%    m and the variance-covariance matrix C given as inputs.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvmdist.m,v 1.2 2001/12/04 09:34:16 rune Exp $	

[xr,xc] = size(X);

md = zeros(xr,1);

if (exist('m')==1),
  [yr,yc] = size(m);
  if (xc ~= yc),
    error('mvmdist: X and m must have the same number of columns!');
  end
  Xc = mvcenter(X,m);
else
  [Xc,m] = mvcenter(X);
end

if (~exist('C')),
  C = (Xc' * Xc) / (xr - 1);
end

for k=1:xr,
  md(k) = sqrt(Xc(k,:) * inv(C) * Xc(k,:)');
end

% end of mvmdist.m