function [nonans, naninrows, nanincols, nanvals] = mvreplacenan(X)
%MVREPLACENAN -- find and replace elements with non-numbers
%
%  Usage:
%    [nonans, naninrows, nanincols, nanvals] = mvreplacenan(X)
%
%  Inputs:
%    X               data matrix
%
%  Outputs:
%    nonans          data matrix where nans are replaced with column mean
%    naninrows       row indexes
%    nanincols       column indexes
%    nanvals         matrix indexes ... to nan values
%
%  Description:
%    replace nan's with row means to make them unimportant
%    in the model
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvreplacenan.m,v 1.2 2001/12/04 10:05:19 rune Exp $	

nanvals = find(isnan(X));
nanincols = find(isnan(sum(X)));
naninrows = find(isnan(sum(X')));

for i = nanincols
  nan_replacer = mean(X(find(~isnan(X(:,i)))));
  X(find(isnan(X(:,i))),i) = nan_replacer;
end
nonans = X;

%end of mvreplacenan
