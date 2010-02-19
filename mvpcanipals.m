function [T,P,eigv,varpc,X] = mvpcanipals(X, maxfact)
%MVPCANIPALS -- NIPALS algorithm (Wold, 1966) for Principal Component Analysis
%
%  Usage:
%    [T,P,eigv,varpc,RES] = mvpcanipals(X, maxfact)
%  
%  Inputs:
%    X        is the input matrix, objects in rows
%    maxfact  is an optional limit on the number of factors calculated
%
%  Outputs:
%    T        is the matrix containing the scores
%    P        is the matrix containing the loadings (column oriented)
%    eigv     is the eigenvalues for each calculated factor
%    varpc    is the accumulated variance captured for each PC
%    RES      is the residual matrix
%  
%  Description:
%    The algorithm extracts one factor at a time. Each factor is
%    obtained iteratively by repeated regressions of X on scores
%    t to obtain improved p, and on these p to obtain improved t.
%    Source: "Multivariate Calibration", Martens/Naes, 1989.
%  
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvpcanipals.m,v 1.3 2001/12/05 07:58:57 rune Exp $	

% find the matrix size
[m,n]=size(X);

% What arguments did we get?
if nargin > 2,
  % More than two arguments is not allowed.
  error('Wrong number of input arguments');
  break;
elseif nargin == 2,
  % Cannot do more iterations than number of variables.
  k = min([n,maxfact]);
else
  % Calcularing all possible factors.
  k = n;
end

if k ~= n, % Are we calculating all possible eigenvalues?
  % If not, we calculate the total variance in the data-set.
  vartot = sum(sum((X).^2));
end

if abs(max(mean(X))) > 1e3*eps,
  % Is the matrix mean centered? If not, issue a warning!
  warning('Input matrix is not mean centered! Please consider doing this!');
end

tol = 1e3*eps;      % tolerance (convergence criteria)
maxit = 100;        % max number of iterations pr. factor
T = zeros(m,k);     % initialize the score matrix
P = zeros(n,k);     % initialize the loading matrix
eigv = ones(k,1);   % initialize the eigenvalue vector
varpc = zeros(k,1); % initialize the variance vector

% The NIPALS PCA algorithm.
for a=1:k,
   % Selecting the initial t. Using the column with
   % the highest remaining sum of squares.
   [maxval,maxcol]=max(sum(X.^2));
   t = X(:,maxcol);
   % Variables used for the convergence criterium.
   convlim = 1;
   eigv_old = eigv(a);
   % Initial estimate on eigenvalue.
   eigv(a) = t'*t;
   % Counting number of iterations for each component.
   itnum = 0;
   while convlim > tol, % Convergence criteria.
      % Counting number of iterations.
      itnum = itnum + 1;
      % Improve estimate of loading-vector p.
      % (inv(t'*t)*t' is the pseudoinverse.
      p = (inv(t'*t)*t' * X)';
      % Scale length of p to 1.0.
      p = p / sqrt(p'*p);
      % Improve estimate on score t.
      t = X * p*inv(p'*p);
      % Improve estimate on eigenvalue.
      eigv_old = eigv(a);
      eigv(a) = t'*t;
      convlim = abs(eigv(a)-eigv_old);
      if itnum > maxit, % Max number of iterations.
	error('Did not converge after max number of iterations, quitting.');
	break;
      end
   end
   % Subtract the effect of the calculated factor.
   X = X - t*p';
   if k ~= n, % Are we calculating all possible eigenvalues?
     % Calculate the remaining sum of squares for the complete 
     % data-set (but only if not all eigenvalues are computed).
     varpc(a)= sum(sum((X).^2));
   end
   % Store the scores in T.
   T(:,a) = t;
   % Store the loadings in P.
   P(:,a) = p;
end

% VARPC is the X variance captured in each factor.
if k == n, % If all eigenvalues are computed, then...
  varexp = (eigv/sum(eigv)); % a temp placeholder...
  for a=1:k, % The accumulated variance explained for each PC
    varpc(a)=sum(varexp(1:a));
  end
else
  for a=1:k, % The accumulated variance explained for each PC
    varpc(a) = (vartot-varpc(a))/vartot;
  end
end
