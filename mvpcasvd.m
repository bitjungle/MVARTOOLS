function [T, P, eigv, varpc, res] = mvpcasvd(X, maxfact,method)
%MVPCASVD -- Principal Component Analysis using Singular Value Decomposition
%
%  Usage:
%    [T, P, eigv, varpc, res] = mvpcasvd(X, maxfact)
%
%  Inputs:
%    X        is the input matrix (objects (samples) in rows)
%    maxfact  is an optional limit on the number of factors kept
%    method   'normaleq' (default) or 'direct'
%
%  Outputs:
%    T        matrix containing the scores
%    P        column vector containing the loadings
%    eigv     eigenvalues for each calculated factor
%    res      residual matrix
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

%	$Id: mvpcasvd.m,v 1.2 2001/12/04 09:42:40 rune Exp $	

% find the number of variables
[m,n] = size(X);

if (nargin == 2) | (nargin == 3),
  % cannot find more PC's than number of variables
  k = min([n, maxfact]);
elseif (nargin == 1) | (isempty(k) == 1),
  k = n;
end

if nargin < 3,
  % the default method
  method = 'normaleq';
end

if abs(max(mean(X))) > 1e3*eps,
  warning('Input matrix is not mean centered! Please consider doing this!');
end

% 1. SVD
if strcmp(method, 'normaleq'),
  XX = X'*X; 
  [U,S,VT] = svd(XX);
else %if strcmp(method, 'direct')
  [U,S,VT] = svd(X);
end

% Extract the eigenvalues.
eigv=diag(S);
nocomp = length(eigv);

if k < nocomp,
  eigv=eigv(1:k);
else
  k = nocomp;
end

% Find the loading vectors.
P = VT(:,1:k);
% Calculate the scores.
T = X*P;

% VARPC is the X variance captured in each factor.
varexp = (eigv(1:k)/sum(eigv));
for a=1:k, % The accumulated variance explained for each PC
  varpc(a)=sum(varexp(1:a));
end

% The residual matrix.
res = X - T*P';
