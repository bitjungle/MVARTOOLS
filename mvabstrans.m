function [Y] = mvabstrans(X)
%MVABSTRANS -- Convert spectral absorbance data to transmittance
%
%  Usage:
%    [Y] = mvabstrans(X)
%  
%  Inputs:
%    X        is the input absorbance data matrix, objects in rows
%
%  Outputs:
%    Y        is the output transmittance data matrix
%  
%  Description:
%    Convert spectral absorbance data to transmittance.
%    T = (1/10^T)
%    See also 'mvtransabs'.
%  
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

Y = 1./(10.^X);

% end of mvabstrans