function mvdensityplot(x,y,res,scale,zres)
%MVDENSITYPLOT -- data density image plot
%  Usage:
%    mvdensityplot(x,y,res,scale,zres)
%
%  Inputs:
%    x, y     input data
%    res      number of dots to split data area into (optional, default 1% but max 50)
%    scale    set maximum level (optional, maximum density default)
%    zres     number of levels (optional)
%
%  Outputs:
%
%  Description:
%    PCA score plot with highest colormap value set to 1% of total
%    data and split into 5 levels, e.g. one white spot indicates 
%    40 of 4000 data points. Very useful function when visualizing
%    large amounts of data. Example of invocation:
%    >> mvdensityplot(t(:,1),t(:,2),[],size(t,1)*.01,5)
%    The default colormap is 'hot', see: >> help graph3d for more
%    colormaps.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvdensityplot.m,v 1.2 2001/12/04 09:26:30 rune Exp $	

x = x(:);
y = y(:);

if (~exist('res')) | (size(res)==[0 0]),
  res = floor(length(x)*0.01);
  if res > 50,
    res = 50;
  end
end

xr = (x - min(x)) / (max(x)-min(x));
xr = round(xr*(res-1)) + 1;
yr = (y - min(y)) / (max(y)-min(y));
yr = round(yr*(res-1)) + 1;

x0 = (0 - min(x)) / (max(x)-min(x));
x0 = round(x0*(res-1)) + 1;
y0 = (0 - min(y)) / (max(y)-min(y));
y0 = round(y0*(res-1)) + 1;

count = zeros(res);

for i = 1:res,
  for j = 1:res,
    c = find( xr == i & yr == j );
    count(j,i) = length(c);
  end
end

maxpercent = max(max(count))/length(x);
countimg = count;

if (exist('zres')==1) & (size(zres)~=[0 0]),
  scal = zres./max(max(countimg));
  countimg = round(countimg.*scal);
end

if (exist('scale')==1) & (size(scale)~=[0 0]),
  scal = 64/scale;
else
  scal = 64./max(max(countimg));   % colormap resolution is 64
end
countimg = countimg.*scal;

image(flipud(countimg))

set(gca,'XTick',x0,'XTickLabel',[])
set(gca,'YTick',y0,'YTickLabel',[])

colormap(hot)

% end of file
