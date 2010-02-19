function [Xsnv] = mvsnv(X)
%MVSNV -- Standard Normal Variate normalisation
%
%  Usage:
%    [Xsnv] = mvsnv(X) 
%
%  Inputs:
%    X      the input data matrix 
%
%  Outputs:
%    Xsnv   the SNV-corrected data
%
%  Description:
%    Reduces scattering effects in spectral data by normalizing each
%    spectrum by the standard deviation of the responses across the 
%    entire spectral range.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvsnv.m,v 1.2 2001/12/04 10:08:41 rune Exp $	

% finding the size of X
[rx,cx] = size(X);

% mean response
mr = mean(X,2);

% remove the response mean
rdiff = X - repmat(mr,1,cx);

% SNV correction
Xsnv = rdiff./repmat(sqrt(sum(rdiff.^2,2)/(cx-1)),1,cx);
