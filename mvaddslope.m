function [outspect]=mvaddslope(inspect,sign,ang);
%MVADDSLOPE -- add slope to spectrum
%
%  Usage:
%    [outspect]=mvaddslope(inspect,sign,mult);
%
%  Input:
%    inspect   input spectrum
%    sign      sign of the slope (-1/0/1)
%    ang       angle of the slope (in radians, default pi*5/180)
%
%  Output:
%    outspect  spectrum with slope added
%
%  Description:
%    This function adds a slope to the input spectrum. If sign = 0 is
%    given, the input spectrum is left unaltered. The wavelength
%    (x) axis is considered to be of length 1/10 (just to make
%    suitable slopes...).
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvaddslope.m,v 1.2 2001/12/04 09:07:55 rune Exp $	

[m,n] = size(inspect);

if nargin < 3,
  ang = (5/180)*pi;
end

x = linspace(0,((1/10)/cos(ang)),n);
x = repmat(x,m,1);

if sign == -1,
  outspect = inspect - x;
elseif sign == 0,
  outspect = inspect;
elseif sign == 1,
  outspect = inspect + x;
else
  error('sign: legal values: -1 / 0 / 1')
end

% end of mvaddslope