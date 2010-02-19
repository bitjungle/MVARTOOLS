%	$Id: mvdemo4.m,v 1.2 2001/12/04 09:23:30 rune Exp $	
% Script for testing the mvartools package
% Analysis of variations in a spectrum - A full factorial design
% 
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.
%
% Design factors:
%   1. Wavelength shift
%   2. Offset
%   3. Multiplicative contribution
%   4. Baseline slope
%   5. Sine wave

basename = 'mvdemo4'; % base name for plots
author   = 'RM';      % author initials
plotnum  = 0;         % plot counter

% constructing the design matrix
design = mvffdesign(5);

% number of objects are 2^5
[objects,factors] = size(design);

% create "spectrum" (design center)
x = [0:0.01:pi];
dcent=1+(0.5*sin(2*x)+0.5*sin(4*x+2));


% run the experiment
for i=1:objects,
  shift      = mvwlshift(dcent,design(i,1));
  offset     = mvaddoffset(shift,design(i,2),0.1) - shift;
  mult       = mvaddmult(shift,design(i,3),0.25) - shift;
  slope      = mvaddslope(shift,design(i,4),pi*30/180) - shift;
  sine       = mvaddsine(shift,30,0.005,design(i,5)) - shift;
  ddata(i,:) = shift + offset + mult + slope + sine;
  % finally, add some normally distributed random noise
  ddata(i,:) = mvaddnrandom(ddata(i,:),0.001); 
end

% analyze the data

% mean centering
preprocessed = mvcenter(ddata);

% number of factors to extract
maxfact = 6;

% do a pca on the experimental data
[T, P, eigv, varpc, RES] = mvpcasvd(preprocessed, maxfact);

% plot the results
figure
  plotnum = plotnum+1;
  plotname = [basename '-' int2str(plotnum)];
  plot(1:length(x),ddata)
  axis tight
  grid on
  title('Design data')
  mvregplot(plotname,author)
figure
  plotnum = plotnum+1;
  plotname = [basename '-' int2str(plotnum)];
  for k=1:6,
    subplot(3,2,k)
    plot(1:length(x),P(:,k))
    title(['Loadings, PC' int2str(k)])
    axis tight
    grid on
  end
  mvregplot(plotname,author)
figure
  plotnum = plotnum+1;
  plotname = [basename '-' int2str(plotnum)];
  subplot(3,2,1)
  plot(T(:,1),T(:,2),'.')
  grid on
  xlabel('PC1')
  ylabel('PC2')
  subplot(3,2,2)
  plot(T(:,1),T(:,3),'.')
  grid on
  xlabel('PC1')
  ylabel('PC3')
  subplot(3,2,3)
  plot(T(:,2),T(:,3),'.')
  grid on
  xlabel('PC2')
  ylabel('PC3')
  subplot(3,2,4)
  plot(T(:,2),T(:,4),'.')
  grid on
  xlabel('PC2')
  ylabel('PC4')
  subplot(3,2,5)
  plot(T(:,3),T(:,4),'.')
  grid on
  xlabel('PC3')
  ylabel('PC4')
  subplot(3,2,6)
  plot(T(:,5),T(:,6),'.')
  grid on
  xlabel('PC5')
  ylabel('PC6')
  mvregplot(plotname,author)
  
 
% analysis results:
%
a11 = corrcoef(T(:,1),design(:,1));
a12 = corrcoef(T(:,1),design(:,2));
a13 = corrcoef(T(:,1),design(:,3));
a14 = corrcoef(T(:,1),design(:,4));
a15 = corrcoef(T(:,1),design(:,5));
a21 = corrcoef(T(:,2),design(:,1));
a22 = corrcoef(T(:,2),design(:,2));
a23 = corrcoef(T(:,2),design(:,3));
a24 = corrcoef(T(:,2),design(:,4));
a25 = corrcoef(T(:,2),design(:,5));
a31 = corrcoef(T(:,3),design(:,1));
a32 = corrcoef(T(:,3),design(:,2));
a33 = corrcoef(T(:,3),design(:,3));
a34 = corrcoef(T(:,3),design(:,4));
a35 = corrcoef(T(:,3),design(:,5));
a41 = corrcoef(T(:,4),design(:,1));
a42 = corrcoef(T(:,4),design(:,2));
a43 = corrcoef(T(:,4),design(:,3));
a44 = corrcoef(T(:,4),design(:,4));
a45 = corrcoef(T(:,4),design(:,5));
a51 = corrcoef(T(:,5),design(:,1));
a52 = corrcoef(T(:,5),design(:,2));
a53 = corrcoef(T(:,5),design(:,3));
a54 = corrcoef(T(:,5),design(:,4));
a55 = corrcoef(T(:,5),design(:,5));

corr = ...
[a11(1,2) a12(1,2) a13(1,2) a14(1,2) a15(1,2);
 a21(1,2) a22(1,2) a23(1,2) a24(1,2) a25(1,2);
 a31(1,2) a32(1,2) a33(1,2) a34(1,2) a35(1,2);
 a41(1,2) a42(1,2) a43(1,2) a44(1,2) a45(1,2);
 a51(1,2) a52(1,2) a53(1,2) a54(1,2) a55(1,2)];

clear a1* a2* a3* a4* a5*

disp('Study the following matrix. Which PC correlates with the applied effects?')
columnnames=sprintf('\t PC \t wl \t off \t mult \t base \t sine')
disp([[1:5]' corr])
