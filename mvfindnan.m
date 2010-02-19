function [nanobj]=mvfindnan(X)
%MVFINDNAN -- find objects (rows) with non-numbers
%
%  Usage:
%    [nanobj] = mvfindnan(X)
%
%  Inputs:
%    X        data matrix or array
%
%  Outputs:
%    nanobj   is a vector containing the row numbers in X
%             that contains non-numbers
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

%	$Id: mvfindnan.m,v 1.2 2001/12/04 09:31:43 rune Exp $	

[m,n]=size(X);

if (m==1 | n== 1),
   nanval=isnan(X);
else
   nanval=isnan(sum(X'))';
end

nanobj=find(nanval == 1);

%end of mvfindnan