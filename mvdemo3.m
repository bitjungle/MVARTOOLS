clc
format compact
echo on
% Script for testing the mvartools package (PLS)
%	$Id: mvdemo3.m,v 1.2 2001/12/04 09:22:49 rune Exp $	
%
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.


% The acoustics data will now be loaded.

load acoustics1.mat

% It's wise to plot (and study) the raw data first ;-)

figure
subplot(2,1,1)
plot(1:length(Arun_spect),Arun_spect)
axis tight
xlabel('Raw data')
grid on

% The raw data look's noisy, lets smooth it just a little bit...!
[Arun_spect2] = mvsavgol(Arun_spect,3,2,0);
subplot(2,1,2)
plot(1:length(Arun_spect),Arun_spect)
axis tight
xlabel('Smoothed data')
grid on

% Next, we'll do a full cross-validation, calculating
% eight latent variables.
% Press any key to continue...
pause

% max number of latent variables to use in cross validation
maxlv = 5;
figure
[press,cumpress,rmsecv,rmsec,pred] = ...
    mvcrossval(Arun_spect,Arun_conc,'plsnip',maxlv,'full',[],2);

% Study the RMSECV.
% Press any key to continue...
pause

% Now, we'll let a heuristic algoritm decide on how many
% latent variables to use in the finished model, and then
% calculate it.

uselv = mvoptlv(rmsecv)

% Now, lets mean center the data.
% Press any key to continue...
pause

[spect,mspect]=mvcenter(Arun_spect);
[conc,mconc]=mvcenter(Arun_conc);

[b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(spect,conc,uselv);

% We want to study the regression coefficients
% Press any key to continue...
pause
figure
plot(1:length(spect),b(uselv,:))
axis tight
grid on

% Finally, we want to plot the finished model.
% Press any key to continue...
pause
figure
mvpmplot(pred(:,uselv),Arun_conc,uselv,1,rmsecv(uselv),'RMSECV')

echo off