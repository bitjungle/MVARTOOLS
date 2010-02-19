function [outdata] = mvrevarscale(X,xsdev)
%MVREVARSCALE -- rescales the data in a variance scaled matrix 
%
%  Usage:
%    [outdata] = mvrevarscale(X,xsdev) 
%
%  Inputs:
%    X        the data matrix to be rescaled
%    xsdev    vector with standard deviations for each column
%
%  Outputs:
%    outdata  is the rescaled data
%
%  Description:
%    Rescale a variance scaled matrix, see 'mvvarscale'.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvrevarscale.m,v 1.2 2001/12/04 10:06:01 rune Exp $	

if (nargin ~= 2), % wrong number of input arguments
  error('Wrong number of input arguments! Usage: mvrevarscale(X,xsdev)');
  break;
end

[m,n] = size(X);

outdata = X .* (ones(m,1) * xsdev);

% end of mvrevarscale