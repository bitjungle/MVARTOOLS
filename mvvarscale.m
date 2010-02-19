function [Xscaled,xsdev] = mvvarscale(X,xsdev)
%MVVARSCALE -- scales the data in a matrix to unit variance
%
%  Usage:
%    [Xscaled,xsdev] = mvvarscale(X,xsdev)
%
%  Inputs:
%    X        the data matrix to be scaled
%    xsdev    a scaling vector (optional)
%
%  Outputs:
%    Xscaled  is the scaled data
%    xsdev    vector with standard deviations for each column
%
%  Description:
%    Variance scale a matrix: dividing each entry in the matrix by its
%    column standard deviation. To rescale the matrix, use 'mvrevarscale'.
%    To scale a matrix with a previously calculated scaling vector,
%    use two inputs.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvvarscale.m,v 1.2 2001/12/04 10:17:53 rune Exp $	

% finding the size of X
[m,n] = size(X);

% finding the standard deviation vector
if nargin == 1,
  xsdev = std(X);
end

% dividing each entry by its column standard deviation (or input
% scaling vector)
Xscaled = X ./ (ones(m,1) * xsdev);

% end of mvvarscale