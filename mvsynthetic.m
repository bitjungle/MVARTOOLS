%	$Id: mvsynthetic.m,v 1.3 2001/12/04 10:14:06 rune Exp $	
% Script for generating the synthetic dataset
%
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

numsamp = 240;
noiselevel = 0.01;
baselineshift = linspace(0.0001,0.4,numsamp/2);
baselineslope = linspace(0.001,0.4,numsamp/4);
multiplicative = linspace(1.0001,1.1,numsamp/8);

xvar = 0:0.1:pi;
numvar = length(xvar);

X1pure = sin(xvar);
X2pure = sin(xvar+1);
X3pure = sin(xvar-1);

% plot(1:numvar,X1pure,1:numvar,X2pure,1:numvar,X3pure)
% axis tight
% legend('1','2','3')

y1 = rand(numsamp,1);
% add a tiny little bit of autocorrelation between the samples
y1 = mvdigfilt(y1,0.5);

y2 = rand(numsamp,1);

[r,c]=find((y1+y2)>1.0);
y2(r)=1-y1(r);

y3 = 1-y1-y2;

X1 = repmat(X1pure,numsamp,1) .* repmat(y1,1,numvar);
X2 = repmat(X2pure,numsamp,1) .* repmat(y2,1,numvar);
X3 = repmat(X3pure,numsamp,1) .* repmat(y3,1,numvar);

X = X1+X2+X3;

X = mvaddnrandom(X,noiselevel);

for k=((numsamp-(numsamp/2))+1):numsamp,
  X(k,:) = X(k,:)+baselineshift(k-(numsamp-(numsamp/2)));
end
for k=((numsamp-(numsamp/4))+1):numsamp,
  X(k,:) = mvaddslope(X(k,:),1,baselineslope(k-(numsamp-(numsamp/4))));
end
for k=((numsamp-(numsamp/8))+1):numsamp,
  X(k,:) = X(k,:)*multiplicative(k-(numsamp-(numsamp/8)));
end

[T,P] = mvpcasvd(mvcenter(X),4);
%mvscoreplot(T,1,2,1)

Xc = X(1:numsamp/4,:);
Xv = X((numsamp/4)+1:end,:);
y1c = y1(1:numsamp/4,:);
y1v = y1((numsamp/4)+1:end,:);
y2c = y2(1:numsamp/4,:);
y2v = y2((numsamp/4)+1:end,:);
y3c = y3(1:numsamp/4,:);
y3v = y3((numsamp/4)+1:end,:);

save synthetic.mat Xc Xv y1c y1v y2c y2v y3c y3v T P X1pure X2pure  X3pure -V4
