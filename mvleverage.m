function [h] = mvleverage(scores)
%MVLEVERAGE -- find individual object leverages
%
%  Usage:
%    [h] = mvleverage(scores) 
%
%  Inputs:
%    scores  the score matrix from PCA | PCR | PLS
%
%  Outputs:
%    h       the object leverages
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

%	$Id: mvleverage.m,v 1.2 2001/12/04 09:33:34 rune Exp $	

h = diag(scores*inv(scores'*scores)*scores');
