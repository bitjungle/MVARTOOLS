%MVARTOOLS
% Copyright (C) 1999-2001 - Rune Mathisen <mvartools@bitjungle.com>
%	$Id: contents.m,v 1.3 2001/12/16 12:05:07 rune Exp $	
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
%
% Help and information:
%   contents      - this file
%   mvreadme      - release notes
%   mvchanges     - changes since previous release
%   mvwarranty    - warranty information
%   mvcopying     - the GNU general public license
%
% Data Scaling and Preprocessing:
%   mvcenter      - mean centers the data in a row-wise matrix
%   mvobjcenter   - object centers a row-wise matrix
%   mvrecenter    - re-centers data in a row-wise matrix
%   mvvarscale    - scales the data in a matrix to unit variance
%   mvrevarscale  - rescales the data in a variance scaled matrix 
%   mvdelobjects  - delete objects (rows) in a matrix
%   mvmedsmooth   - moving median smoothing
%   mvmeansmooth  - moving mean smoothing
%   mvsavgol      - Savitsky-Golay polynomial smoothing or derivation
%   mvsnv         - Standard Normal Variate normalisation
%   mvdigfilt     - 1st order digital filter
%
% NaN values:
%   mvfindnan     - find objects (rows) with non-numbers
%   mvreplacenan  - find and replace elements with non-numbers
%   mvremnan      - removes any rows in a matrix containing NaN
%
% Plotting:
%   mvscoreplot   - plot scores from PCA or PLS
%   mvnumplot     - plot with numbers as plot symbols
%   mvstrplot     - plot with text strings as plot symbols
%   mvstatplot    - plot mean spectrum, std and relative std
%   mvpmplot      - predicted vs. measured plot
%   mvregplot     - add legend with filename and date
%   mvdensityplot - data density image plot
%
% Statistics:
%   mvvariance    - finds the variance of each column in a matrix
%   mvpmstats     - predicted/measured statistics
%
% Principal Components:
%   mvpcanipals   - NIPALS algorithm for Principal Component Analysis
%   mvpcasvd      - PCA using singular value decomposition
%
% Linear Regression:
%   mvmlr         - multiple linear regression
%   mvpcrsvd      - Principal Component Regression based on SVD
%   mvplsnipals   - Partial Least Squares regression using NIPALS
%   mvplsnipcore  - PLS NIPALS core
%   mvplsregcoeff - Calculate PLSR regression coefficients
%   mvrpls        - Recursive Partial Least Squares regression
%   mvpredict     - predict y-values from linear multivariate model
%   mvfullpredict - predict y-values from PLS loading weights
%   mvoptlv       - find optimal number of latent variables
%
% Validation:
%   mvcrossval    - cross validation (full, random, block)
%   mvcvbyclass   - cross validation by class belongings
%   mvtestval     - test-set validation of multivariate model
%
% Experimental design:
%   mvffdesign    - create two-level full/fractional factorial design matrix
%
% Spectroscopy:
%   mvabstrans    - Convert spectral absorbance data to transmittance
%   mvtransabs    - Convert spectral transmittance data to absorbance
%   mvintf        - calculates interference filter wavelength (and wavenumber)
%   mvaddsine     - adds a sine to the input data
%   mvaddrandom   - adds random noise to spectra
%   mvaddnrandom  - adds normally distributed random noise to spectra
%   mvaddslope    - add slope to spectrum
%   mvaddoffset   - add offset to spectrum
%   mvaddmult     - add multiplicative effect to spectrum
%   mvwlshift     - wavelength shift input spectrum
%
% Miscellaneous:
%   mvmdist       - mahalanobis distance
%   mvedist       - euclidian distance
%   mvextractclass- extract X and y data for one specific class
%   mvwritecals   - write matrix to a CALS table
%
% Matlab/Octave compability
%   mvomtest      - test whether the application is Octave or Matlab
%
% MVARTOOLS Test data-sets and demo-scripts:
%   acoustics1    - acoustics data: spectra and concentration
%   acoustics2    - acoustics data: spectra, concentration and temperature
%   synthetic     - synthetic data: three constituents in a closed data-set
%   iris          - the famous iris data-set
%   distdata      - data for testing distance measures (mahalanobis/euclidian)
%   mvtest        - script for testing all MVARTOOLS functions
%   mvdemo1       - demo-script for doing PCA on the iris data-set
%   mvdemo2       - demo script using PCR
%   mvdemo3       - demo script using PLS
%   mvdemo4       - demo script using factorial design
%   mvdemo5       - demo script using cross- and testset validation
%   mvdemo6       - demo script
%   mvdemo7       - demo script
%   mvdemo8       - demo script
%   mvdemo9       - demo script
