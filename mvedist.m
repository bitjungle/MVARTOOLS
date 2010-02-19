function [me] = mvedist(X,m)
%MVEDIST -- euclidian distance
%
%  Usage: 
%    [me] = mvedist(X,m)
%
%  Inputs:
%    X      unknow sample data
%    m      model mean (optional)
%
%  Outputs:
%    me     Euclidian distance from model data mean
%
%  Description:
%    TBD
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvedist.m,v 1.2 2001/12/04 09:28:09 rune Exp $	

[xr,xc] = size(X);

me = zeros(xr,1);

if (nargin == 2),
  [yr,yc] = size(m);
  if (xc ~= yc),
    error('mvedist: X and m must have the same number of columns!');
  end
  Xc = mvcenter(X,m);
else
  Xc = mvcenter(X);
end

for k=1:xr,
  me(k) = sqrt(Xc(k,:) * Xc(k,:)');
end

% end of mvedist.m