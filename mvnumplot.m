function [] = mvnumplot(X,Y,color,startingnumber)
%MVNUMPLOT -- plot with numbers as plot symbols
%
%  Usage:
%    mvnumplot(X,Y[,color,startingnumber])
%
%  Inputs:
%    X               vector, X-axis data
%    Y               vector, Y-axis data
%    color           string or 1-by-3 rgb color specification,
%                    'white' or 'w', or 'many:' followed by a
%                    colormap name (e.g. 'many:hot')
%    startingnumber  integer, number of the first point
%
%  Description:
%    This function provides plotting with e.g object (row) numbers
%    as plotting symbols.
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

%	$Id: mvnumplot.m,v 1.3 2001/12/13 22:08:50 rune Exp $	

% bad fix of strange bug...
[xr,xc]=size(X);
[yr,yc]=size(Y);
if xr<xc,
  X = X'
end
if yr<yc,
  Y = Y'
end

if nargin < 3
  color = [];
end

if isempty(color)
  co = get(0,'defaultaxescolororder');
  color = co(1,:);
end

if nargin < 4
  startingnumber = 1;
end

colorindex = ones(1,size(X,1));

if findstr(color,'many:')
  colormap = color(6:length(color));
  numcolors = 128;
  colorcommand = ['color = ', colormap, '(numcolors);'];
  eval(colorcommand)
  colorindex = round(linspace(1,numcolors,size(X,1)));
end

plotcommand = plot(X,Y,'k.');
set(plotcommand,'markersize',1)

for i=1:size(X,1)
  label = text( X(i), Y(i), int2str(i+startingnumber-1) );
  set(label, ...
          'FontSize',8, ...
          'Color',color(colorindex(i),:), ...
          'VerticalAlignment','middle', ...
          'HorizontalAlignment','center')
end

% find max and min in plot
%maxx = max(X);
%minx = min(X);
%maxy = max(Y);
%miny = min(Y);


% end of mvnumplot
