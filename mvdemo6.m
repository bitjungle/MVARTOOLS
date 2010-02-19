%	$Id: mvdemo6.m,v 1.2 2001/12/04 09:24:17 rune Exp $	
% Script for testing the mvartools package
%
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.


disp('Demonstration of the mvdensityplot function.')
disp('This function is useful when visualizing large amount of data.')

% create data
xvars=0:0.1:2*pi;
x1 = sin(2*xvars);
x2 = sin(2*xvars+1);
x3 = sin(3*xvars);
x4 = sin(3*xvars+1);

%plot(1:length(xvars),[x1' x2' x3' x4'])

disp('Constructing data matrix...')
X(1:1000,:) = 4*randn(1000,1)*x1 ...
            + randn(1000,1)*x2 ...
            + randn(1000,1)*x3 ...
            + randn(1000,1)*x4;
X(1001:2000,:) = randn(1000,1)*x1 ...
            + 4*randn(1000,1)*x2 ...
            + randn(1000,1)*x3 ...
            + randn(1000,1)*x4;
X(2001:3000,:) = randn(1000,1)*x1 ...
            + randn(1000,1)*x2 ...
            + 4*randn(1000,1)*x3 ...
            + randn(1000,1)*x4;
X(3001:4000,:) = randn(1000,1)*x1 ...
            + randn(1000,1)*x2 ...
            + randn(1000,1)*x3 ...
            + 4*randn(1000,1)*x4;

disp('Doing PCA...')
[T,P,eigv,varpc,RES] = mvpcasvd(mvcenter(X),4);

disp('Plotting may take some time, please wait...')
figure
mvdensityplot(T(:,1),T(:,2))
colormap(hot)
xlabel('PC1')
ylabel('PC2')
%figure
%mvscoreplot(T,1,2)

%end of file