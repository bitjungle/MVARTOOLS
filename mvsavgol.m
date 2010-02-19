function [Y] = mvsavgol(X,window,poly,order)
%MVSAVGOL Savitsky-Golay polynomial smoothing or derivation
%
%  Usage:
%    [Y] = mvsavgol(X,window,poly,order)
%
%  Inputs:
%    X       input matrix
%    window  number of variables included
%    poly    degree of the polynom
%    order   order of the derivation
%    Y       derivated/smoothed output matrix
%
% Description: 
%    This function runs a Savitsky-Golay polynomial smoothing or
%    derivation of the row vectors of matrix X, and returns the
%    derived matrix Y. The number of variables included is given in
%    'window', and the degree of the polynom is given by 'poly'. The
%    variable 'order' defines the order of derivation (default to
%    0). If 'order=0' the input is smoothed.
%
%  Source:
%    "Generalized digital smoothing filters made easy by matrix calculations"
%    Stephen E. Bialkowski, Analytical Chemistry, Vol.61, No.11, 1989
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvsavgol.m,v 1.2 2001/12/04 10:07:04 rune Exp $	

if exist('order') == 0,
  % Default value if no argument given
  order = 0; 
end

if order >= poly, 
  error('Order must be less than the degree of the polynom!');
end

if round(window/2) == (window/2),
  error('Only odd variable numbers allowed');
end

% Constructing the Vandermonde matrix.
V = ones(window,poly);
V(:,2)=[1:window]';
for j=3:poly,
  V(:,j)=V(:,2).^(j-1);
end
    
D1 = zeros(poly,poly);
for i = 1:(poly-1),
   D1(i,i+1) = i;
end

Xhat = V*D1^order*inv(V'*V)*V';

[rX,cX] = size(X);

% Algorithm works with column oriented data,
% transpose input
X       = X';

mid     = (window+1)/2;

% Initialize output matrix
Y       = zeros(cX,rX);

for i = 1:rX,
   yhat = Xhat*X(1:window,i);
   Y(1:mid,i) = yhat(1:mid);

   yhat = Xhat*X(((cX-window+1)):cX,i);
   Y((cX-mid):cX,i) = yhat((mid-1):window);

   for j = (mid+1):(cX-mid-1),
      Y(j,i) = Xhat(mid,:)*X((j-mid+1:j+mid-1),i);
   end
end

% Flip back to row oriented data
Y = Y';