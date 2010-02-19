function mvstatplot(X,xaxis)
%MVSTATPLOT -- plot mean spectrum, std and relative std
%
%  Usage:
%    mvstatplot(X) 
%
%  Inputs:
%    X      is the matrix containing the raw data
%    xaxis  is an optional vector for x axis values
%
%  Outputs:
%
%  Description:
%    Simple function for initial data study.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvstatplot.m,v 1.2 2001/12/04 10:09:21 rune Exp $	

% finding the size of X
[m,n] = size(X);

if nargin == 1,
  xaxis = 1:n;
end

% calculating the mean spectrum
xmean=mean(X);

% calculating the standard deviation
xstd=std(X);

% calculating the relative standard deviation
sn = xmean./xstd;

% plotting
subplot(3,1,1)
  plot(xaxis,xmean,'m')
  title('Mean spectrum')
  axis tight;
  grid on;
subplot(3,1,2)
  plot(xaxis,xstd,'r')
  title('Standard deviation')
  axis tight;
  grid on;
subplot(3,1,3)
  plot(xaxis,sn,'k')
  title('Relative standard deviation')
  axis tight;
  grid on;
