function [Y] = mvtransabs(X)
%MVTRANSABS -- Convert spectral transmittance data to absorbance
%
%  Usage:
%    [Y] = mvtransabs(X)
%  
%  Inputs:
%    X        is the input transmittance data matrix, objects in rows
%
%  Outputs:
%    Y        is the output absorbance data matrix
%  
%  Description:
%    Convert spectral transmittance data to absorbance.
%    A = log10(1/T)
%    See also 'mvabstrans'.
%  
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvtransabs.m,v 1.2 2001/12/04 10:16:48 rune Exp $	

Y = log10(1./X);

% end of mvtransabs