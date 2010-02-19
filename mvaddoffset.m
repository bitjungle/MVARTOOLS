function [outspect]=mvaddoffset(inspect,sign,offset);
%MVADDOFFSET -- add offset to spectrum
%
%  Usage:
%    [outspect]=mvaddoffset(inspect,sign,offset);
%
%  Input:
%    inspect   input spectrum
%    sign      sign of the offset (-1/0/1)
%    offset    offset to add (optional, default 0.1)
%
%  Output:
%    outspect  spectrum with offset added
%
%  Description:
%    This function adds an offset spectrum to the input
%    spectrum. If sign = 0 is given, the input spectrum is left
%    unaltered.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvaddoffset.m,v 1.2 2001/12/04 09:05:40 rune Exp $	

if nargin < 3,
  offset = 0.1;
end

if sign == -1,
  outspect = inspect - offset;
elseif sign == 0,
  outspect = inspect;
elseif sign == 1,
  outspect = inspect + offset;
else
  error('sign: legal values: -1 / 0 / 1')
end

% end of mvaddofset