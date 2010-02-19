function [a,idx]=mvremnan(X)
%MVREMNAN -- removes any rows in a matrix containing NaN
%
%  Usage:
%    [a,idx] = mvremnan(X)
%
%  Inputs:
%    X       the data matrix containing NaN
%
%  Outputs:
%    a       the new matrix with no NaN (contains fewer rows than X)
%    idx     an index vector containing the rows of x that is present in a
%
%  Description:
%    Removes all the rows in a matrix that contains NaN. This
%    function is mainly used by other functions as a subfunction.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvremnan.m,v 1.2 2001/12/04 10:04:15 rune Exp $	

% locates the matrix that does not contain NaN

% finding the rows in X which contains NaN values.
c=sum(isnan(X)');
% removing those rows.
a=X(find(c==0),:);

% giving the indexvector if asked for.
if nargout==2
   idx=find(c==0);
end
