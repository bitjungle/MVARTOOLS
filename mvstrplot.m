function [] = mvstrplot(x,y,strvector,color)
%MVSTRPLOT -- plot with text strings as plot symbols
%
%  Usage:
%    mvstrplot(x,y,strvector,color)
%
%  Inputs:
%    x           column vector, x-axis data
%    y           column vector, y-axis data
%    strvector   column vector with plot-strings (char array)
%    color       string or 1-by-3 rgb color specification,
%                'white' or 'w', or 'many:' followed by a
%                colormap name (e.g. 'many:hot') (optional)
%
%  Description:
%    This function provides plotting with text strings as plotting
%    symbols.
%
%  Side effects:
%    To get proper scaling this function plots a black plot first,
%    this will of course give you a problem when printing or
%    displaying the figure with another background color,
%    i.e. whitebg('white').  Also supports different color for
%    each point. This option suffers from a serious MEMORY problem
%    though. Avoid it by closing the figure window prior to
%    plotting.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvstrplot.m,v 1.2 2001/12/04 10:09:56 rune Exp $	

[m,n] = size(x);

if n ~= 1,
  error('Input must be a column vector!')
end

if nargin < 4,
  color = [];
end

if isempty(color),
  co = get(0,'defaultaxescolororder');
  color = co(1,:);
end

colorindex = ones(1,m);

if findstr(color,'many:'),
  colormap = color(6:length(color));
  numcolors = 128;
  colorcommand = ['color = ', colormap, '(numcolors);'];
  eval(colorcommand)
  colorindex = round(linspace(1,numcolors,m));
end

plotcommand = plot(x,y,'k.');
set(plotcommand,'markersize',1)

for i=1:m,
  label = text( x(i), y(i), strvector(i,:) );
  set(label, ...
          'FontSize',8, ...
          'Color',color(colorindex(i),:), ...
          'VerticalAlignment','middle', ...
          'HorizontalAlignment','center')
end

% end of mvstrplot
