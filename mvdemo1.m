clc
format compact
echo on
% Script for testing the mvartools package (PCA)
%	$Id: mvdemo1.m,v 1.2 2001/12/04 09:14:34 rune Exp $	
%
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

% Loading the data to analyze...
load iris

% First, we'll preprocess by mean center the data. You should
% always do this before doing a PCA! If you don't, the first PC is
% wasted on a vector pointing from origo to the center of the data
% sworm.
X = mvcenter(iris);

% Next, well do a PCA extracting three factors.
% Press any key to continue...
pause

[T,P,eigv,varpc,res]=mvpcanipals(X,3);

% Lets plot the results
echo off
figure
subplot(2,2,1);% plotting scores
  mvscoreplot(T,1,2,1);
subplot(2,2,2);% plot the loadings for comp. 1 and 2
  mvstrplot(P(:,1),P(:,2),irisvarnames)
  title('Loadings')
  xlabel('PC1')
  ylabel('PC2')
  grid on
subplot(2,2,3);% plot explained variance
  bar(varpc)
  title('Explained variance (cumulative)')
  xlabel('PC no.')
  ylabel('Variance')
subplot(2,2,4);% plot residual variance
  bar(mvvariance(res'))
  title('Sample residual variance')
  xlabel('Sample no.')
  ylabel('Variance')
echo on

% What if we center and variance scale it (i.e "autoscaling")?
% Lets try the 'pcasvd' function at the same time. The syntax is
% identical to the 'pcanipals' algorithm.
% Press any key to continue...
pause

X = mvvarscale(X);

% PCA, three factors
[T,P,eigv,varpc,res]=mvpcasvd(X,3);

% Lets plot the results
echo off
figure
subplot(2,2,1);% plotting scores
  mvscoreplot(T,1,2,1);
subplot(2,2,2);% plot the loadings for comp. 1 and 2
  mvstrplot(P(:,1),P(:,2),irisvarnames)
  title('Loadings')
  xlabel('PC1')
  ylabel('PC2')
  grid on
subplot(2,2,3);% plot explained variance
  bar(varpc)
  title('Explained variance (cumulative)')
  xlabel('PC no.')
  ylabel('Variance')
subplot(2,2,4);% plot residual variance
  bar(mvvariance(res'))
  title('Sample residual variance')
  xlabel('Sample no.')
  ylabel('Variance')
echo on

% The autoscaling didn't really give better discrimination, we'll
% drop that.
%
% Object 36 might be an outlier. Lets remove it, and try again.
% Press any key to continue...
pause

X = mvdelobjects(iris,36);
objnames = mvdelobjects(irisobjnames,36);

% center the reduced matrix
X = mvcenter(X);

% PCA, three factors
[T,P,eigv,varpc,res]=mvpcanipals(X,3);

% Lets plot the results
echo off
figure
subplot(2,2,1);% plotting scores
  mvscoreplot(T,1,2,1);
subplot(2,2,2);% plot the loadings for comp. 1 and 2
  mvstrplot(P(:,1),P(:,2),irisvarnames)
  title('Loadings')
  xlabel('PC1')
  ylabel('PC2')
  grid on
subplot(2,2,3);% plot explained variance
  bar(varpc)
  title('Explained variance (cumulative)')
  xlabel('PC no.')
  ylabel('Variance')
subplot(2,2,4);% plot residual variance
  bar(mvvariance(res'))
  title('Sample residual variance')
  xlabel('Sample no.')
  ylabel('Variance')
echo on

% Finally, we'll make a large score plot for PC 1 & 2, and use the
% object names as plot symbols. It's easy to discriminate between
% the three types of Iris (se,ve,vi) using only two variables.
% Press any key to continue...
pause

figure
mvstrplot(T(:,1),T(:,2),objnames(:,1:2),'many:cool')
xlabel('PC1')
ylabel('PC2')
grid on

echo off