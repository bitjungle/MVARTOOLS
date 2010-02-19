function [press,sep,rmse,slope,bias,offset,r] = mvpmstats(pred,meas)
%MVPMSTATS -- predicted/measured statistics
%
%  Usage:
%    [press,sep,rmse,slope,bias,offset,r] = mvpmstats(pred,meas)
%
%  Inputs:
%    pred    predicted results (vector)
%    meas    reference measurements (vector)
%	     
%  Outputs:  
%    press   predicted error sum of squares
%    sep     standard error of performance
%    rmse    root mean square error of (cross-validation | prediction)
%    slope   slope of the least squares line between predicted and measured
%    bias    average error between predicted and measured
%    offset  point where the regression line crosses the y axis
%    r       correlation coefficient
%
%  Description:
%    Calculates common statistics measures for a multivariate
%    calibration model. 
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvpmstats.m,v 1.2 2001/12/04 09:47:10 rune Exp $	

[m,n] = size(pred);
[p,q] = size(meas);

% predicted error sum of squares
press = (pred - meas).^2;

% root mean square error
rmse = sqrt(sum(press,1)/m);

% Bias
bias = sum(pred - meas)/m;

% standard error of performance
sep  = sqrt(sum((pred - meas - bias).^2)/(m-1));

% slope and offset
[P,S]  = polyfit(meas,pred,1);
slope  = P(1);
offset = P(2);

% correlation coefficient
%r2 = sum((pred - mean(meas)).^2)/sum((meas - mean(meas)).^2);
%r2 = sum(((pred - mean(pred)).*(meas - mean(meas))).^2)/...
%     (sum((pred - mean(pred)).^2)*(sum((meas - mean(meas)).^2)));

ccmat = corrcoef(pred,meas);
r = ccmat(1,2);

%end of mvpmstats
