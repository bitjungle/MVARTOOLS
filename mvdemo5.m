%	$Id: mvdemo5.m,v 1.2 2001/12/04 09:23:53 rune Exp $	
% Script for testing the mvartools package
% 
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.
%

disp('Calibration and test-set validation')

load synthetic.mat

basename = 'mvdemo5'; % base name for plots
author   = 'RM';      % author initials
plotnum  = 0;         % plot counter

% number of latent variables to extract
maxlv = 3;

% Do a random block cross-validation, dividing the calibration into
% 10 blocks.
[press,cumpress,rmsecv,rmsec,pred,B3d] = ...
    mvcrossval(Xc,y3c,'plsnip',maxlv,'rand',10,0);

% Plot the result using two latent variables
figure
  plotnum = plotnum+1;
  plotname = [basename '-' int2str(plotnum)];
  mvpmplot(pred(:,2),y3c,2,[],rmsecv(2),'RMSECV');
  
% mean centering
[Xccenter,xmean] = mvcenter(Xc);
[y3ccenter,y3mean] = mvcenter(y3c);

% Make the final model
[b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(Xccenter,y3ccenter,maxlv);

% Test-set validation ------------------------------------------------

% First we need to center the new data
Xvcenter = mvcenter(Xv,xmean);

% Do the validation
[vpress,vcumpress,vrmsep,vpred] = mvtestval(Xvcenter,y3v,b,2,y3mean);

% Plot the result using two latent variables
figure
  plotnum = plotnum+1;
  plotname = [basename '-' int2str(plotnum)];
  mvpmplot(vpred(:,2),y3v,2,[],vrmsep(2),'RMSEP');
