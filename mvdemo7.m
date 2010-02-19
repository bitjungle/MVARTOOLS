% Script for testing the mvartools package
%	$Id: mvdemo7.m,v 1.3 2001/12/04 08:53:13 rune Exp $	
%
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

% This script demonstrates PLS2

load synthetic.mat

% This is a closed dataset with three components, i.e. the correct
% number of latent variables must be 2.
lv = 2;

[b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(mvcenter(Xc),[y1c y2c y3c],lv);

figure
subplot(2,1,1)
plot(1:length(X1pure),[X1pure' X2pure' X3pure']);
axis tight
xlabel('pure spectra')
subplot(2,1,2)
plot(1:length(b),b);
axis tight
xlabel('reg.coeff. from PLS2')