function [sinespect]=mvaddsine(X,freq,ampl,sign,plots)
%MVADDSINE -- adds a sine to the input data
%
%  Usage:
%    [sinespect] = mvaddsine(X,freq,ampl,sign,plots) 
%
%  Inputs:
%    X          is the input data matrix or vector
%    freq       is the frequency of the sine (in Hz)
%               Optional: default value is 100Hz
%    ampl       is the amplitude of the sine
%               Optional: default value is 0.1
%    sign       Optional: sign of frequency (-1 0 1)
%    plots      Optional: if 1, plot input and output spectra
%
%  Outputs:
%    sinespect
%
%  Description:
%    This function adds a sine to the input spectra. The input
%    spectra are considered to be a one second time window.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvaddsine.m,v 1.2 2001/12/04 09:07:15 rune Exp $	

defaultfreq = 100;
defaultampl = 0.1;

if (nargin == 1),
  freq = defaultfreq;
  ampl = defaultampl;
  sign = 1;
  plots = 0;
elseif (nargin == 2),
  ampl = defaultampl;
  sign = 1;
  plots = 0;
elseif (nargin == 3),
  sign = 1;
  plots = 0;
elseif (nargin == 4),
  plots = 0;
end

if isempty(freq),
  freq = defaultfreq;
end
if isempty(ampl),
  ampl = defaultampl;
end
if isempty(sign),
  sign = 1;
end

% find size of input spectra
[m,n]=size(X);

% "time" vector, n equally spaced points from 1 to n,
% with numerical values between 0 and 1
t = linspace(0,n,n)/n;

% create the sine to apply on the input spectra
sinespect = ampl*sin(2*pi*sign*freq*t);
sinespect = repmat(sinespect,m,1);

% add sine to the input spectrum
sinespect = X + sinespect;

% plotting
if plots == 1,
  figure
  subplot(2,1,1);
    plot(1:n,X,'b');
    title('Original spectra');
  subplot(2,1,2);
    plot(1:n,sinespect,'r');
    title(['Sine added. Frequency: ' num2str(freq) ...
	   ' Amplitude: ' num2str(ampl)]);
end

% end of mvaddsine