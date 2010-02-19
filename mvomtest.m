function [app,appstr]=mvomtest()
%MVOMTEST -- test whether the application is Octave or Matlab
%
%  Usage:
%    [app,appstr] = mvomtest
%
%  Outputs:
%    app     is an integer: octave=0, matlab=1 (unknown=2)
%    appstr  is a string with possible values: octave/matlab(/unknown)
%
%  Description:
%    This function may be used to test whether it is executed under:
%    Octave (http://www.octave.org) 
%    or 
%    Matlab (http://www.mathworks.com).
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvomtest.m,v 1.2 2001/12/04 09:40:18 rune Exp $	

if nargin ~= 0,
  warning('omtest: ignoring extra arguments');
end

tmpvar = exist('OCTAVE_VERSION');

if tmpvar == 0,
  app = 1;
  appstr = 'matlab';
elseif tmpvar == 5;
  app = 0;
  appstr = 'octave';
else
  app = 2;
  appstr = 'unknown';
end

% end of omtest.m
  
