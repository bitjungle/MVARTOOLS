function [matrix]=mvffdesign(k,p)
%MVFFDESIGN -- create two-level full/fractional factorial design matrix
%
%  Usage:
%    [matrix]=mvffdesign(k,p)
%    
%  Inputs:
%    k       number of variables
%    p       fraction (optional)
%
%  Outputs:
%    matrix  design matrix
%
%  Description:
%    Returns a fractional factorial 2^(k-p) design matrix.
%    If p=0, a complete factorial design is returned.
%    Not compatible with octave: char function missing.
%    Source: Statistics for experimenters 
%    - an introduction to design, data analysis and model building
%    G. E. P. Box, W. G. Hunter, J. S. Hunter, Wiley, 1978
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvffdesign.m,v 1.2 2001/12/04 09:31:04 rune Exp $	

if nargin==1, 
  p = 0; % full factorial design
end

k0 = k;
k  = k - p;

x = char(ones(2^k,k)*48);
matrix = zeros(2^k,k);

% set up design levels
for i = 1:2^k,
  s = dec2bin(i-1);
  x(i,k+1-length(s):k) = s;
end

x = fliplr(x);

% convert to numbers
for i = 1:2^k*k
  matrix(i) = str2num(x(i));
end

% fractional factorial designs (table on page 410 in Box, Hunter & Hunter)
if (k0 > 7) & (p > 0),
    error('Fractional design with more than 7 variables is not implemented!')
end
if (nargin == 2),
    if k0 == 3,
        if p == 1,
            matrix(:,3) = ~xor(matrix(:,1),matrix(:,2));
        elseif p > 1,
            error('p > 1 not possible')
        end
    end
    if k0 == 4,
        if p == 1,
            matrix(:,4) = ~xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3));
        elseif p > 1,
            error('p > 1 not possible')
        end
    end
    if k0 == 5,
        if p == 1,
            matrix(:,5) = ~xor(xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3)),matrix(:,4));
        elseif p == 2,
            matrix(:,4) = ~xor(matrix(:,1),matrix(:,2));
            matrix(:,5) = ~xor(matrix(:,1),matrix(:,3));
        elseif p > 2,
            error('p > 2 not possible!')
        end
    end
    if k0 == 6,
        if p == 1,
            matrix(:,6) = ~xor(xor(xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3)),matrix(:,4)),matrix(:,5));
        elseif p == 2,
            matrix(:,5) = ~xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3));
            matrix(:,6) = ~xor(xor(matrix(:,2),matrix(:,3)),matrix(:,4));
        elseif p == 3,
            matrix(:,4) = ~xor(matrix(:,1),matrix(:,2));
            matrix(:,5) = ~xor(matrix(:,1),matrix(:,3));
            matrix(:,6) = ~xor(matrix(:,2),matrix(:,3));
        elseif p > 3,
            error('p > 3 not possible!')
        end
    end
    if k0 == 7,
        if p == 1,
            matrix(:,7) = ~xor(xor(xor(xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3)),matrix(:,4)),matrix(:,5)),matrix(:,6));
        elseif p == 2,
            matrix(:,6) = ~xor(xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3)),matrix(:,4));
            matrix(:,7) = ~xor(xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3)),matrix(:,5));
        elseif p == 3,
            matrix(:,5) = ~xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3));
            matrix(:,6) = ~xor(xor(matrix(:,2),matrix(:,3)),matrix(:,4));
            matrix(:,7) = ~xor(xor(matrix(:,1),matrix(:,3)),matrix(:,4));
        elseif p == 4,
            matrix(:,4) = ~xor(matrix(:,1),matrix(:,2));
            matrix(:,5) = ~xor(matrix(:,1),matrix(:,3));
            matrix(:,6) = ~xor(matrix(:,2),matrix(:,3));
            matrix(:,7) = ~xor(xor(matrix(:,1),matrix(:,2)),matrix(:,3));
        elseif p > 4,
            error('p > 4 not possible!')
        end
    end
end

% end of mvffdesign
