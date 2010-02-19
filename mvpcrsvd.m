function [B,T,P,eigv,xres,yres] = mvpcrsvd(X,y,maxfact,method)
%MVPCRSVD -- Principal Component Regression based on SVD
%
%  Usage
%    [B,T,P,eigv,xres] = mvpcrsvd(X,y,maxfact,method)
%
%  Inputs:
%    X        calibration data absorbance matrix
%    y        calibration data concentration vector
%    maxfact  number of principal components (default is the number of columns)
%    method   'normaleq' (default) or 'direct'
%
%  Outputs:
%    B        regression coefficients
%    T        score vectors
%    P        loading vectors
%    eigv     eigenvalues for each calculated factor
%    xres     residual X matrix
%    yres     residual y vector
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

%	$Id: mvpcrsvd.m,v 1.2 2001/12/04 09:43:21 rune Exp $	

if abs(max(mean(X))) > 1000*eps,
  % Is the X matrix mean centered? If not, issue a warning!
  warning('Input matrix is not mean centered! Please consider doing this!');
end

% find the X matrix size
[m,n]=size(X);

if nargin < 3,
  k = size(X,2);
elseif (nargin == 3) | (nargin == 4),
  % Cannot find more PC's than number of variables.
  k = min([n, maxfact]);
end

if nargin < 4,
  % The default method.
  method = 'normaleq';
end

% 1. SVD
if strcmp(method, 'normaleq'),  % X'*Y = X'*X*B + X'*Y
  XX = X'*X; 
  Y  = X'*y;
  [U,S,VT] = svd(XX);
else %if strcmp(method, 'direct')  % Y = X*B + E
  [U,S,VT] = svd(X);
  Y = y;
end

% Extract the eigenvalues.
eigv=diag(S);
nocomp = length(eigv);

if k < nocomp,
  eigv=eigv(1:k);
else
  k = nocomp;
end

% 2. PCA
% Find the loading vectors.
P = VT(:,1:k);
% Calculate the scores.
T = X*P;
% The residual X matrix.
xres = X - T*P';

% 3. PCR
% Calculate regression coefficients.
for f = 1:k,
  U1 = U(:,1:f);
  S1 = S(1:f,1:f);
  V1 = VT(:,1:f);
  B(f,:) = (V1*inv(S1)*U1'*Y)';
end

% The residual y vector.
yres = y - X*B(k,:)';

% end of mvpcrsvd
