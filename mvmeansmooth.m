function [Xs] = mvmeansmooth(X,w)
%MVMEANSMOOTH -- moving mean smoothing
%
%  Usage:
%    [Xs] = mvmeansmooth(X,w);
% 
%  Inputs:
%    X      data matrix to smooth
%    w      window size
%
%  Outputs:
%    Xs     smoothed spectra
%
%  Description:
%    Moving mean smoothing. Output is truncated by (ceil(w/2)-1).
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvmeansmooth.m,v 1.2 2001/12/04 09:35:16 rune Exp $	

if (nargin ~= 2), % wrong number of input arguments
  error('Wrong number of input arguments! Usage: mvmedsmooth(X,w)');
  break;
end

% finding the size of X
[m,n] = size(X);

wu=ceil(w/2);
wl=floor(w/2);

Xs = zeros(m,n-wu-1);

for b=(1+wl):(n-wu),
  % moving mean with window size w
  Xs(:,(b-wl)) = mean(X(:,(b-wl):(b+wu)),2);
end
