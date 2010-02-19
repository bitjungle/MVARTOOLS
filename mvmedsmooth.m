function [Xsmooth] = mvmedsmooth(X,w)
%MVMEDSMOOTH -- moving median smoothing
%
%  Usage:
%    [Xsmooth] = mvmedsmooth(X,w);
% 
%  Inputs:
%    X        data matrix to smooth
%    w        window size
%
%  Outputs:
%    Xsmooth  smoothed spectra
%
%  Description:
%    Moving median smoothing. Output is truncated by (ceil(w/2)-1).
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvmedsmooth.m,v 1.2 2001/12/04 09:35:51 rune Exp $	

if (nargin ~= 2), % wrong number of input arguments
  error('Wrong number of input arguments! Usage: mvmedsmooth(X,w)');
  break;
end

% finding the size of X
[m,n] = size(X);

wu=ceil(w/2);
wl=floor(w/2);

Xsmooth = zeros(m,n-wu-1);
size(Xsmooth)
for b=(1+wl):(n-wu),
  % moving median with window size w
  Xsmooth(:,(b-wl)) = median(X(:,(b-wl):(b+wu)),2);
end
