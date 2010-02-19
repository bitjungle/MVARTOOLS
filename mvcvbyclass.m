function [press,cumpress,rmsecv,rmsec,pred,B3d] = mvcvbyclass(X,y,class,rm,lv,mc,verb)
%MVCVBYCLASS -- cross validation by class belongings
%
%  Usage:
%    [press,cumpress,rmsecv,rmsec,pred,B3d] = mvcvbyclass(X,y,class,rm,lv,mc,verb)
%
%  Inputs:
%    X         regression data (matrix)
%    y         response data (vector)
%    class     sample class belonging (double or char array)
%    rm        regression method to use (plsnip|pcr)
%    lv        max number of latent variables to calculate
%    mc        no scaling (0), mean centering (1), auto-scaling (2)
%    verb      if 1, be verbose, if 2, do plotting also!
%	   
%  Outputs:
%    press     predicted error sum of squares
%    cumpress  cumulated predicted error sum of squares
%    rmsecv    root mean square error of cross validation
%    rmsec     root mean square error of calibration
%    pred      cross validation predicted values
%    B3d       all cross-validation regression coefficients, stored
%              in a 3d array (lv x vars x classes), ref: H. Martens.
%
%  Description: 
%    Cross validation by class belonging. For more model statistics,
%    use 'mvpmstats'. Called by 'mvcrossval', and uses 'mvextractclass'.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvcvbyclass.m,v 1.2 2001/12/04 09:13:13 rune Exp $	

% default regression method
if (exist('rm') == 0) | (isempty(rm) == 1),
  rm = 'nip';
end
% default number of factors to calculate
if (exist('lv') == 0) | (isempty(lv) == 1),
  lv = rank(X,0.1);
end
% default scaling
if (exist('mc') == 0) | (isempty(mc) == 1),
  mc = 1;
end
% do not be verbose by default
if exist('verb') == 0,
  verb = 0;
end
% if verbose, create a figure now
if verb == 2,
  figure
end

% find size of X matrix
[m,n] = size(X);

% index y to keep track of the entries
idx = [1:m]';
y   = [idx y];

% if class is a double vector, make sure its a column vector
if ~ischar(class),
  [classr,classc] = size(class);
  if (classr == 1) | (classc == 1),
    if classr == 1,
      class = class';
    end
  else
    error('class input must be a double or char vector')
  end
end

% find all unique classes in the class vector
allclass = unique(class,'rows');
[numclass,chars] = size(allclass);

% initializing variables
pred  = zeros(m,lv);
err   = zeros(m,lv);
cpred = zeros(m,lv);
cerr  = zeros(m,lv);
B3d   = zeros(lv,n,numclass);% multidimentional

for i=1:numclass,% for each unique class, do:

  % extract the current class
  [Xcal,ycal,Xtest,ytest] = mvextractclass(X,y,class,allclass(i,:));
  
  % extract our index entries
  tidx  = ytest(:,1);
  ytest = ytest(:,2);
  
  % center or autoscale the current matrix
   if mc == 1,
    [Xcal,mX] = mvcenter(Xcal);
    [ycal,my] = mvcenter(ycal(:,2));
   elseif mc == 2,
    [Xcal,stdX] = mvvarscale(Xcal);
    [Xcal,mX] = mvcenter(Xcal);
    [ycal,my] = mvcenter(ycal(:,2));
   else
    ycal = ycal(:,2);
    my   = 0;
  end
      
  % select regression method (and regress)
  if strcmp(rm,'plsnip') == 1,
    [b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(Xcal,ycal,lv);
  elseif strcmp(rm,'pcr') == 1,
    [b,T,P,eigv,xres] = mvpcrsvd(Xcal,ycal,lv,'direct');
  else
    error('Regression methods: plsnip | pcr');
  end
  
  % store the regression coefficients
  B3d(:,:,i) = b;

  % scale the test object
  [tobj,tvar] = size(Xtest);
  switch mc
   case 1,
    Xtest = mvcenter(Xtest,mX);
   case 2,
    Xtest = mvvarscale(Xtest,stdX);
    Xtest = mvcenter(Xtest,mX);
  end

  for j=1:lv,% for each calculated latent variable, do:
    % do prediction (and rescale)
    pred(tidx,j) = mvpredict(Xtest,b,j,my);
    % how much did we miss?
    err(tidx,j) = pred(tidx,j) - ytest(ones(tobj,1),:);
  end
  
  % verbose mode
  if verb == 1|2,
    sqerr = err(tidx,:).^2;
    [a,b]=min(sqerr);
    if verb == 1,
      disp(['Squared prediction error for class ' int2str(i)]);
      out=sprintf('LV\tSQERR');disp(out);
      for i=1:lv,
	out=sprintf('%d\t%6.2f',i,sqerr(i));disp(out);
      end
      disp(' ');
    end
    if verb == 2,
      plot(1:lv,sqerr,'-o')
      title(['Class ' int2str(i) ' -- ' allclass(i,:) ' -- '...
	     int2str(numclass-i) ' classes left'])
      xlabel('latent variables')
      ylabel('squared error')
      axis ([0.5 (lv+0.5) 0 max(max(sqerr))])
      grid on
      refresh
      pause(0.01)
    end
  end
end

% statistics
for k=1:lv,
  [press(:,k),sec(k),rmsecv(k)] = mvpmstats(pred(:,k),y(:,2));
end
cumpress = sum(press,1);

% Final model using all samples
[Xfinal,mxfinal] = mvcenter(X);
[yfinal,myfinal] = mvcenter(y(:,2));

if strcmp(rm,'plsnip') == 1,
  [b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(Xfinal,yfinal,lv);
elseif strcmp(rm,'pcr') == 1,
  [b,T,P,eigv,xres] = mvpcrsvd(Xfinal,yfinal,lv,'direct');
else
  error('This error is not possible!?')
end

for j=1:lv,% for each latent variable, do:
  cpred(:,j) = mvrecenter(mvpredict(Xfinal,b,j),myfinal);
  cerr(:,j)  = cpred(:,j) - y(:,2);
end

rmsec = sqrt(sum(cerr.^2)./m);

if verb == 1,
  disp('Final results:')
  out=sprintf('LV\tRMSECV\tRMSEC');disp(out);
  for i=1:lv,
    out=sprintf('%d\t%6.2f\t%6.2f',i,rmsecv(i),rmsec(i));disp(out);
  end
elseif verb == 2,
  plot(1:1:lv,rmsecv,'-ob',1:1:lv,rmsec,'-sr')
  title('Prediction error')
  legend('RMSECV','RMSEC')
  xlabel('Latent variables')
  grid on
end

% end of mvcvbyclass