function [Y] = mvrecenter(X,xmean)
%MVRECENTER -- re-centers data in a row-wise matrix
%
%  Usage:
%    [Y] = mvrecenter(X,xmean) 
%
%  Inputs:
%    X      the data matrix to re-center
%    xmean  a vector containing the column means
%
%  Outputs:
%    Y      the re-centered data
%
%  Description:
%    This function re-centers a data matrix by using the 'xmean'
%    input. See the function 'mvcenter'.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvrecenter.m,v 1.2 2001/12/04 10:01:22 rune Exp $	

% finding the size of X
[m,n] = size(X);

Y = X + ones(m,1)*xmean;

% end of mvrecenter