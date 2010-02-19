clc
format compact
echo on
% Script for testing the mvartools package
%	$Id: mvtest.m,v 1.5 2001/12/13 22:13:54 rune Exp $	
% 
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.
%

tic

% loading test data
load synthetic.mat

% testing the functions in alphabetical order

%MVABSTRANS -- Convert spectral absorbance data to transmittance
[Xca] = mvabstrans(Xc);

%MVADDOFFSET -- add multiplicative effect to spectrum
[Xtmp] = mvaddmult(Xc,1,0.1);

%MVADDRANDOM -- adds normally distributed random noise to spectra
[Xtmp] = mvaddnrandom(Xc,0.1,0);

%MVADDOFFSET -- add offset to spectrum
[Xtmp] = mvaddoffset(Xc,1,0.1);

%MVADDRANDOM -- adds random noise to spectra
[Xtmp] = mvaddrandom(Xc,0.1,0);

%MVADDSINE -- adds a sine to the input data
[Xtmp] = mvaddsine(Xc(1,:),100,0.1,1,0);

%MVADDSLOPE -- add slope to spectrum
[Xtmp] = mvaddslope(Xc,1,pi*5/180);

%MVCENTER -- mean centers the data in a row-wise matrix
% mvcenter have two different functionalities
[Xcentc,xmean] = mvcenter(Xc);
[Xcentv] = mvcenter(Xv,xmean);
[ycentc,ymean] = mvcenter(y1c);
[ycentv] = mvcenter(y1v,ymean);

%MVCROSSVAL -- cross validation
% mvcrossval can be used in many different ways...
[press,cumpress,rmsecv,rmsec,pred,B3d] = ...
    mvcrossval(Xc,y1c,'plsnip',4,'full',[],0);
[press,cumpress,rmsecv,rmsec,pred,B3d] = ...
    mvcrossval(Xc,y1c,'pcr',4,'rand',4,0);
[press,cumpress,rmsecv,rmsec,pred,B3d] = ...
    mvcrossval(Xc,y1c,'plsnip',4,'block',4,0);

%MVCVBYCLASS -- cross validation by class belongings
aclass = find(y1c < 0.3);
bclass = find((y1c >= 0.3)&(y1c < 0.6));
cclass = find(y1c >= 0.6);
classnames = zeros(length(y1c),1);
classnames(aclass) = 1; classnames(bclass) = 2; classnames(cclass) = 3;
[press,cumpress,rmsecv,rmsec,pred,B3d] = ...
    mvcvbyclass(Xc,y1c,classnames,'plsnip',3,2,0);

%MVDELOBJECTS -- delete objects (rows) in a matrix
[Xtmp,deleted] = mvdelobjects(Xc,aclass);

%MVDENSITYPLOT -- data density image plot
figure
mvdensityplot(Xv(:,1),Xv(:,10),10);

%MVDIGFILT -- 1st order digital filter
[Xtmp] = mvdigfilt(Xc(1,:),0.5);

%MVEDIST -- euclidian distance
[me1] = mvedist(Xc);
[me2] = mvedist(Xv,xmean);

%MVEXTRACTCLASS -- extract X and y data for one specific class
[Xtmp,ytmp,Xprod,yprod] = mvextractclass(Xc,y1c,bclass,1);

%MVFFDESIGN -- create two-level full/fractional factorial design matrix
[matrix]=mvffdesign(5,2);

%MVFINDNAN -- find objects (rows) with non-numbers
% create some NaN entries first, then lets see if we can fint them...
Xnan=Xc; Xnan(2,3) = NaN; Xnan(50,100)=NaN;
[nanobj] = mvfindnan(Xnan);

%MVFULLPREDICT -- predict y-values from PLS loading weights
% must make a calibration model first...
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcentc,ycentc,3);
[ypredxx,tnew,Xres] = mvfullpredict(Xv,w,p,inner,2,q,ymean,xmean);

%MVINTF -- calculates interference filter wavelength (and wavenumber)
[wl,wn] = mvintf(10,10,30,1);

%MVLEVERAGE -- find individual object leverages
[h] = mvleverage(t);

%MVMDIST -- mahalanobis distance
[md1,m,C] = mvmdist(Xc);
[md2] = mvmdist(Xv,m,C);

%MVMEANSMOOTH -- moving mean smoothing
[Xtmp] = mvmeansmooth(Xc,5);

%MVMEDSMOOTH -- moving median smoothing
[Xtmp] = mvmedsmooth(Xc,5);

%MVMLR -- multiple linear regression
b = mvmlr(Xc(:,1:50:end),y1c,1);

%MVNUMPLOT -- plot with numbers as plot symbols
figure
mvnumplot(y1c,y2c,'k',1);

%MVOBJCENTER -- object centers a row-wise matrix
[Xtmp] = mvobjcenter(Xc);

%MVOMTEST -- test whether the application is Octave or Matlab
[app,appstr] = mvomtest;

%MVOPTLV -- find optimal number of latent variables
[optlv] = mvoptlv(rmsecv);

%MVPCANIPALS -- NIPALS algorithm (Wold, 1966) for Principal Component Analysis
[t,p,eigv,varpc,RES] = mvpcanipals(Xcentc,2);

%MVPCASVD -- Principal Component Analysis using Singular Value Decomposition
[t,p,eigv,varpc,RES] = mvpcasvd(Xcentc,2);

%MVPCRSVD -- Principal Component Regression based on SVD
[b,t,p,eigv,xres] = mvpcrsvd(Xcentc,y1c,3,'normaleq');

%MVPLSNIPCORE -- PLS NIPALS core
[p,w,t,u,inner,Xres,yres] = mvplsnipcore(Xcentc,y1c);

%MVPLSNIPALS -- Partial Least Squares regression using NIPALS
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcentc,y1c,3);

%MVPLSREGCOEFF -- Calculate PLSR regression coefficients
[b] = mvplsregcoeff(p,q,w,inner);

%MVPMPLOT -- predicted vs. measured plot
figure
mvpmplot(pred(:,2),y1c,2,1,rmsecv(2),'RMSECV',1);

%MVPMSTATS -- predicted/measured statistics
[press,sep,rmse,slope,bias,offset,r] = mvpmstats(pred(:,2),y1c);

%MVPREDICT -- predict y-values from multivariate model
[ypredx] = mvpredict(Xcentv,b,2,ymean);

%MVRECENTER -- re-centers data in a row-wise matrix
[Xtmp] = mvrecenter(Xcentc,xmean);

%MVREGPLOT -- add legend with filename and date
mvregplot('mvtest','RM');

%MVREMNAN -- removes any rows in a matrix containing NaN
[Xtmp,idx] = mvremnan(Xnan);

%MVREPLACENAN -- find and replace elements with non-numbers
[nonans,naninrows,nanincols,nanvals] = mvreplacenan(Xnan);

%MVREVARSCALE -- rescales the data in a variance scaled matrix
% must make a scaling vector first...
[Xscaled,xsdev] = mvvarscale(Xc);
[Xtmp] = mvrevarscale(Xscaled,xsdev);

%MVRPLS -- Recursive Partial Least Squares regression
[rb,rp,rw,rt,ru,rinner,rXres,ryres] = mvrpls(Xv(1,:),y1v(1),p,t,inner,3,0.9);

%MVSAVGOL Savitsky-Golay polynomial smoothing or derivation
[Xtmp] = mvsavgol(Xc,7,2,1);

%MVSCOREPLOT -- plot scores from PCA
figure
mvscoreplot(t,1,2,1);

%MVSNV -- Standard Normal Variate normalisation
[Xsnv] = mvsnv(Xc);


%MVSTATPLOT -- plot mean spectrum, std and relative std
figure
mvstatplot(Xc);

%MVSTRPLOT -- plot with text strings as plot symbols
strvector=char(classnames+64);
figure
mvstrplot(t(:,1),t(:,2),strvector,'k');

%MVTESTVAL -- test-set validation of multivariate model
[press,cumpress,rmsep,pred] = mvtestval(Xcentv,ycentv,b,2,ymean);

%MVTRANSABS -- Convert spectral transmittance data to absorbance
[Xtmp] = mvtransabs(Xca);

%MVVARIANCE -- finds the variance of each column in a matrix
[Xtmp] = mvvariance(Xc);

%MVVARSCALE -- scales the data in a matrix to unit variance
% mvvarscale have two different functionalities
[Xtmp,xsdev] = mvvarscale(Xc);
[Xtmp] = mvvarscale(Xv,xsdev);

%MVWLSHIFT -- wavelength shift input spectrum
[Xtmp]=mvwlshift(Xc,2);

%MVWRITECALS -- write matrix to a CALS table
mvwritecals(Xc,'testfile','%6.2f');
delete testfile.cals

toc
% the end...
echo off