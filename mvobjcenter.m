function [Xobjcent] = mvobjcenter(X)
%MVOBJCENTER -- object centers a row-wise matrix
%
%  Usage:
%    [Xobjcent] = mvobjcenter(X) 
%
%  Inputs:
%    X         the data matrix with objects to center
%
%  Outputs:
%    Xobjcent  the object centered data
%
%  Description:
%    This function centers each object (row) in a data matrix
%    by subtracting the row mean.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvobjcenter.m,v 1.2 2001/12/13 22:11:52 rune Exp $	

% finding the size of X
[m,n] = size(X);

% calculating the object means
objmean = (mean(X'))';

% subtracting the object means
Xobjcent = X - objmean*ones(1,n);

% end of mvobjcenter