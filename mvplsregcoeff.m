function [b] = mvplsregcoeff(p,q,w,inner)
%MVPLSREGCOEFF -- Calculate PLSR regression coefficients
%	
%  Usage:
%    [b] = mvplsregcoeff(p,q,w,inner)
%	
%  Inputs:
%    p        X loadings
%    q        y loadings (vector for PLS1, matrix for PLS2)
%    w        loading weights
%    inner    vector containing the inner (X/Y scores) relationships
%
%  Outputs:
%    b        regression coefficients
%
%  Description:
%    Calculates Partial Least Squares regression coefficients from
%    X/y loadings, loading weights and X/y inner relations.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvplsregcoeff.m,v 1.2 2001/12/04 11:15:25 rune Exp $	

% Is it PLS1 or PLS2?
[rq,cq] = size(q);
if rq == 1,
  b  = w*inv(p'*w)*diag(inner)*diag(q);
  % make output like pls_toolbox
  b  = cumsum(b',1);
else
  b  = w*inv(p'*w)*diag(inner)*q';  
end
