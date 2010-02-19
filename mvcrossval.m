function [press,cumpress,rmsecv,rmsec,pred,B3d] = mvcrossval(X,y,rm,lv,cvm,bl,verb)
%MVCROSSVAL -- cross validation
%
%  Usage:
%    [press,cumpress,rmsecv,rmsec,pred,B3d] = mvcrossval(X,y,rm,lv,cvm,bl,verb)
%
%  Inputs:
%    X         regression data
%    y         response data
%    rm        regression method to use (plsnip|pcr)
%    lv        max number of latent variables to calculate
%    cvm       cross validation method (full|rand|block)
%    bl        number of blocks, if 'rand' or 'block' is selected
%    verb      if 1, be verbose, if 2, do plotting also!
%	   
%  Outputs:
%    press     prediction residual error sum of squares
%    cumpress  cumulative prediction residual error sum of squares
%    rmsecv    root mean square error of cross validation
%    rmsec     root mean square error of calibration
%    pred      cross validation predicted values
%    B3d       all cross-validation regression coefficients, stored
%              in a 3d array (lv x vars x segments), ref: H. Martens.
%
%  Description: 
%    Multivariate regression cross validation. Data is
%    automatically mean centered. Example of invocation: 
%    >> [press,cumpress,rmsecv,rmsec,pred,B3d] =  ...
%             mvcrossval(spect,cons,'plsnip',6,'full',[],1);
%    For more model statistics, use 'mvpmstats'. See also the
%    validation functions: 'mvcvbyclass' and 'mvtestval'.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvcrossval.m,v 1.2 2001/12/04 09:12:20 rune Exp $	

if exist('rm') == 0,
  rm = 'plsnip';
end

if exist('cvm') == 0,
  cvm = 'full';
end

if exist('verb') == 0,
  verb = 0;
end

switch cvm

 % full cross validation method starts here ---------------------------------
 case 'full'
  if verb == 2,
    figure
  end

  [m,n] = size(X);

  % initializing variables
  testobj = zeros(1,n+1);
  tempX   = zeros(m-1,n);
  tempy   = zeros(m-1,1);
  pred    = zeros(m,lv);
  err     = zeros(m,lv);
  cpred   = zeros(m,lv);
  cerr    = zeros(m,lv);
  B3d     = zeros(lv,n,m);% multidimentional

  for i=1:m,% for each object, do:
    % extract the current test object
    testobj = [X(i,:) y(i)];
    % remove this object from the calibration data
    tempX = mvdelobjects(X,i);
    tempy = mvdelobjects(y,i);
    % center the current matrix
    [tempX,mX] = mvcenter(tempX);
    [tempy,my] = mvcenter(tempy);
    % do a rank check to estimate the number of linearly
    % independent rows or columns of X
    %rx = rank(tempX);
    %if rx < lv,
    %  lv = rx;
    %end
    % select regression method
    if strcmp(rm,'plsnip') == 1,
      [b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(tempX,tempy,lv);
    elseif strcmp(rm,'pcr') == 1,
      [b,T,P,eigv,xres] = mvpcrsvd(tempX,tempy,lv,'direct');
    else
      error('Regression methods: plsnip | pcr');
    end
    
    % store the regression coefficients
    B3d(:,:,i) = b;
    
    for j=1:lv,% for each calculated latent variable, do:
      % scale the test object (remove model mean)
      testx = testobj(1:n) - mX;
      % do prediction
      pred(i,j) = mvrecenter(mvpredict(testx,b,j),my);
      % how much did we miss?
      err(i,j) = pred(i,j) - testobj(n+1);
    end
    % verbose mode
    if verb == 1|2,
      sqerr = err(i,:).^2;
      [a,b]=min(sqerr);
      if verb == 1,
	disp(['Squared prediction error for object ' int2str(i)]);
	disp(['Absolute minima at: ' int2str(b) ' lv']);
	out=sprintf('LV\tSQERR');disp(out);
	for i=1:lv,
	  out=sprintf('%d\t%6.2f',i,sqerr(i));disp(out);
	end
	disp(' ');
      end
      if verb == 2,
	%plot(1:1:lv,sqerr,'-ob')
	bar(1:1:lv,sqerr)
	title(['Object ' int2str(i) ' -- ' int2str(m-i) ' objects left'])
	% text(b-0.2,a+0.5,'minima')
	xlabel('latent variables')
	ylabel('squared error')
	axis ([0.5 (lv+0.5) 0 max(sqerr)])
	grid on
	refresh
	pause(0.01)
      end
    end
  end
  
  % statistics
  press  = err.^2;
  cumpress = cumsum(press);
  rmsecv = sqrt(sum(press,1)/m);
  
  % Final model using all samples
  [Xfinal,mxfinal] = mvcenter(X);
  [yfinal,myfinal] = mvcenter(y);
  
  if strcmp(rm,'plsnip') == 1,
    [b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(Xfinal,yfinal,lv);
  elseif strcmp(rm,'pcr') == 1,
    [b,T,P,eigv,xres] = mvpcrsvd(Xfinal,yfinal,lv,'direct');
  else
    error('This error is not possible!?')
  end
  
  for j=1:lv,% for each latent variable, do:
    cpred(:,j) = mvrecenter(mvpredict(Xfinal,b,j),myfinal);
    cerr(:,j)  = cpred(:,j) - y;
  end
  
  % redundant statistics, cbias and sec may be removed
  rmsec = sqrt(sum(cerr.^2,1)./m);
  cbias = sum(cerr)/m;
  sec   = sqrt(sum((cerr-ones(m,1)*cbias).^2)./(m-1));
  
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
 % full cross validation method ends here -----------------------------------

 case 'rand'
  [m,n] = size(X);
  class = floor(bl*rand(m,1));
  [press,cumpress,rmsecv,rmsec,pred,B3d] = ...
      mvcvbyclass(X,y,class,rm,lv,1,verb);
 
 case 'block'
  [m,n] = size(X);
  segmentsize = floor(m/bl);
  class = zeros(m,1);
  for k = 1:bl,
      class((k-1)*segmentsize+1:k*segmentsize) = k;
  end
  % assign remaining objects to a class
  if bl*segmentsize < m,
     class(k*segmentsize+1:end) = bl; 
  end
  [press,cumpress,rmsecv,rmsec,pred,B3d] = ...
      mvcvbyclass(X,y,class,rm,lv,1,verb);
  
end

% end of mvcrossval