function [wl,wn] = mvintf(t,n,ang,ord)
%MVINTF -- calculates interference filter wavelength (and wavenumber)
%
%
%  Usage:
%    [wl,wn] = mvintf(t,n,ang,ord)
%
%  Inputs:
%    t     filter tickness (scalar)
%    n     refraction index (scalar)
%    ord   interference order (scalar or vector)
%    ang   angle (scalar)
%
%  Outputs:
%    wl    wavelength 
%    wn    wavenumber 
%
%  Description:
%
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvintf.m,v 1.2 2001/12/04 09:32:55 rune Exp $	

wl = (2*t/cos(ang))*n./ord;

wn = wl.^-1;