function [outspect]=mvaddmult(inspect,sign,mult);
%MVADDOFFSET -- add multiplicative effect to spectrum
%
%  Usage:
%    [outspect]=mvaddmult(inspect,sign,mult);
%
%  Input:
%    inspect   input spectrum
%    sign      sign of the multiplicative effect (-1/0/1)
%    mult      size of the multiplicative (default 1e-2)
%
%  Output:
%    outspect  spectrum with multiplicative added
%
%  Description:
%    This function adds a multiplicative effect to the input
%    spectrum. If sign = 0 is given, the input spectrum is left
%    unaltered.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvaddmult.m,v 1.2 2001/12/04 09:02:58 rune Exp $	

if nargin < 3,
  mult = 1e-2;
end

if sign == -1,
  outspect = inspect - inspect .* mult;
elseif sign == 0,
  outspect = inspect;
elseif sign == 1,
  outspect = inspect + inspect .* mult;
else
  error('sign: legal values: -1 / 0 / 1')
end

% end of mvaddmult