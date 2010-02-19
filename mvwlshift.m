function [outspect]=mvwlshift(inspect,shift);
%MVWLSHIFT -- wavelength shift input spectrum
%
%  Usage:
%    [outspect]=mvwlshift(inspect,shift);
%
%  Input:
%    inspect   input spectrum
%    shift     shift to left or right (legal values: -2/-1/0/1/2)
%
%  Output:
%    outspect  shifted spectrum
%
%  Description:
%    This function shifts an input spectrum one or two wavelength
%    units to the left (-1/-2) or right (1/2). If 0 is given as an
%    input value for the variable 'shift', the input spectrum is
%    returned unaltered.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvwlshift.m,v 1.2 2001/12/04 10:20:11 rune Exp $	

[m,n] = size(inspect);

if shift == -2,
  outspect = inspect(:,3:n);
  % filling in the missing columns
  outspect(:,n-1) = inspect(:,(n-1))+(inspect(:,(n-1))-inspect(:,(n-2)))./2;
  outspect(:,n) = inspect(:,n)+(inspect(:,n)-inspect(:,(n-1)))./2;
elseif shift == -1,
  outspect = inspect(:,2:(n));
  % filling in the missing column
  outspect(:,n) = inspect(:,n)+(inspect(:,n)-inspect(:,(n-1)))./2;
elseif shift == 0,
  outspect = inspect;
elseif shift == 1,
  % filling in the missing column
  outspect(:,1) = inspect(:,1)+(inspect(:,2)-inspect(:,1))./2;
  outspect(:,2:n) = inspect(:,1:(n-1));
elseif shift == 2,
  % filling in the missing column
  outspect(:,1) = inspect(:,1)+(inspect(:,2)-inspect(:,1))./2;
  outspect(:,2) = inspect(:,2)+(inspect(:,3)-inspect(:,2))./2;
  outspect(:,3:n) = inspect(:,1:(n-2));
else
  error('legal values: -1 / 0 / 1')
end

% end of mvwlshift