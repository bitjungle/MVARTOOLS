function mvwritecals(X,filename,fstring)
%MVWRITECALS -- write matrix to a CALS table
%
%  Usage:
%    mvwritecals(X,filename,fstring) 
%
%  Inputs:
%    X         the data matrix to print
%    filename  name of the file to print to (optional)
%              suffix '.cals' is appended
%    fstring   format string, e.g '%6.2f' (optional)
%
%  Outputs:
%
%  Description:
%    If no filename is given, output goes to screen.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvwritecals.m,v 1.2 2001/12/04 10:20:58 rune Exp $	

[rx,cx] = size(X);

if (exist('filename') == 0) | isempty(filename) == 1,
  fid = 1;% output to screen
else
  OPENCMD=(['fid = fopen(''' filename '.cals''' ',''w'');']);
  eval(OPENCMD);
end

if (exist('fstring') == 0) | isempty(fstring) == 1,
  fstring = '%.4g';% default format string
end

PRINTCMD = (['fprintf(fid,''<entry>' fstring '</entry>'',X(row,:));']);


fprintf(fid,['<table>\n<title></title>\n<tgroup cols="' int2str(cx) '">\n']);
fprintf(fid,'<tbody>\n');

for row=1:rx,
  fprintf(fid,'<row>\n');
  eval(PRINTCMD);
  fprintf(fid,'\n</row>\n');
end

fprintf(fid,'</tbody>\n</tgroup>\n</table>\n');

if fid ~= 1,
  fclose(fid);
end