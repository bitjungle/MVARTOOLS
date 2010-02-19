function [X,y,Xprod,yprod] = mvextractclass(X,y,objclass,class)
%MVEXTRACTCLASS -- extract X and y data for one specific class
%
%  Usage:
%    [X,y,Xprod,yprod] = mvextractclass(Xdata,ydata,objclass,class)
%
%  Inputs:
%    Xdata     The spectral data
%    ydata     The accompanying y-data
%    objclass  The accompanying class char array
%    class     Name of class to extract
%
%  Outputs:
%    X         Trimmed X matrix     
%    y         The accompanying y-data
%    Xprod     X data for class given in input
%    yprod     The accompanying y-data
%
%  Description:
%    This function extracts X- and y-data for a given class. The
%    function will also give a match if the input given in
%    'class' is a subset of the entries in 'objclass'.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvextractclass.m,v 1.2 2001/12/04 09:29:30 rune Exp $	

match = strmatch(class,objclass);

Xprod = X(match,:);
yprod = y(match,:);

X(match,:) = [];
y(match,:) = [];
