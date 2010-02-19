function [Xcent,xmean] = mvcenter(X,xmean)
%MVCENTER -- mean centers the data in a row-wise matrix
%
%  Usage:
%    [Xcent,xmean] = mvcenter(X,xmean) 
%
%  Inputs:
%    X      the data matrix to mean center
%    xmean  the vector to subtract from each row in X (optional)
%
%  Outputs:
%    Xcent  the mean centered data
%    xmean  a vector containing the column means
%
%  Description:
%    This function centers a data matrix (or vector) by subtracting
%    the column means. To re-center data, use the 'mvrecenter'
%    function. If two inputs are given, the 'xmean' input will be
%    subtracted from each row in 'X'.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvcenter.m,v 1.2 2001/12/04 09:10:22 rune Exp $	

% finding the size of X
[m,n] = size(X);

if (m==1) & (nargin==1),
  error('mvcenter: only one input vector, cannot compute!')
end

% calculating the column means
if nargin == 1,
  xmean = mean(X);
end

% subtracting the means
Xcent = X - ones(m,1) * xmean;

% end of mvcenter