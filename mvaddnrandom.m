function [noisespect]=mvaddnrandom(X,ampl,plots)
%MVADDRANDOM -- adds normally distributed random noise to spectra
%
%  Usage:
%    [noisespect] = mvaddnrandom(X,ampl,plots) 
%
%  Inputs:
%    X           is the input data matrix or vector
%    ampl        is the amplification of the noise (optional)
%    plots       if 1, plot input and output spectra
%
%  Outputs:
%    noisespect  spectra with random noise added
%
%  Description:
%    This function adds normally distributed random noise to the input
%    spectra. The noise is generated using the Matlab randn()
%    function, with values chosen from a normal distribution with mean
%    zero and variance one. To increase/decrease the noise, use the
%    'ampl' input.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvaddnrandom.m,v 1.2 2001/12/04 09:03:38 rune Exp $	

if (nargin == 1),
  ampl = 1;
  plots = 0;
elseif (nargin == 2),
  plots = 0;
end

% find size of input spectra
[m,n]=size(X);

% generate random noise
noise = randn(m,n).*ampl;

% add random noise to spectra
noisespect=X + noise;

% plotting
if plots == 1,
  wl = 1:1:n;
  figure
  subplot(2,1,1);
    plot(wl,X,'b');
    title('Original spectra');
    axis tight
  subplot(2,1,2);
    plot(wl,noisespect,'r');
    title('Noise added.');
    axis tight
end

% end of mvaddnrandom