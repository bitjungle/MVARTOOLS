function mvscoreplot(T,a,b,sym)
%MVSCOREPLOT -- plot scores from PCA
%
%  Usage:
%    mvscoreplot(T,A,B,sym)
%
%  Inputs:
%    T    is the matrix containing the score vectors
%    A    is the PC number for the x axis
%    B    is the PC number for the y axis
%    sym  plots with numbers or user selectable plotting symbols (optional)
%         valid value is any integer (used as a starting number)
%         or e.g. one of the characters 'x' '+' '*' 'o' '.' (default)
%
%  Description:
%    Examples of invocation:
%    >> mvscoreplot(T,1,2)
%    >> mvscoreplot(T,2,4,1)
%    >> mvscoreplot(T,1,3,'*')
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvscoreplot.m,v 1.2 2001/12/04 10:07:39 rune Exp $	

% finding the size of T
[m, n] = size(T);

if nargin == 3,
    plot(T(:,a),T(:,b), '.');
    title('Scores');
    xlabel(['PC ' int2str(a)]);
    ylabel(['PC ' int2str(b)]);
elseif nargin == 4,
    if ischar(sym),
        plot(T(:,a),T(:,b),sym);
    else
        mvnumplot(T(:,a),T(:,b),[],sym);
    end
    title('Scores');
    xlabel(['PC ' int2str(a)]);
    ylabel(['PC ' int2str(b)]);
else
    error('Wrong number of input arguments!');
end

grid on

% end of mvscoreplot