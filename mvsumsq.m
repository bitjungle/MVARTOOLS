function [sumsq] = mvsumsq(X)
%MVSUMSQ -- sum of squares
%
%  Usage:
%    [sumsq] = mvsumsq(X,[dim])
%
%  Inputs:
%    X      the data matrix on which to calculate sum of squares
%    dim    dimension on which to calculate (optional)
%           rows: dim=2 (default)    columns: dim=1
%
%  Outputs:
%    sumsq  sum of squares for each row (or column) in X
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

%	$Id: mvsumsq.m,v 1.2 2001/12/04 10:10:42 rune Exp $	

if nargin==1,
  dim = 2;
end

sumsq = sum(X.^2,dim);

% end of mvsumsq