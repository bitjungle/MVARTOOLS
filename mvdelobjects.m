function [Y,deleted]=mvdelobjects(X,obj)
%MVDELOBJECTS -- delete objects (rows) in a matrix
%
%  Usage:
%    [Y,deleted] = mvdelobjects(X,obj)
%
%  Inputs:
%    X        is the input matrix
%    obj      is a vector containing the row numbers in X
%             that is to be removed
%
%  Outputs:
%    Y        is the trimmed matrix
%    deleted  contains the deleted objects
%
%  Description:
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvdelobjects.m,v 1.2 2001/12/04 09:13:50 rune Exp $	

[m,n]=size(X);
[o,p]=size(obj);

if min(o,p) ~= 1,
  error('Specified objects must be in a vector! Halting...');
  break;
end

if max(obj)> m,
  error('Objects specified goes beyond size of input matrix! Halting...');
  break;
end

Y=X;
deleted = X(obj,:);
Y(obj,:)=[];

%end of mvdelobjetcs