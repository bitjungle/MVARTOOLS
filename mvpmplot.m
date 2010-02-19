function mvpmplot(pred,meas,lv,num,rmse,rmsestr,st)
%MVPMPLOT -- predicted vs. measured plot
%
%  Usage:
%    mvpmplot(pred,meas,lv,num,rmse,rmsestr,st)
%
%  Inputs:
%    pred     predicted values
%    meas     measured values
%    lv       number of latent variables (optional)
%    num      if > 0, plot with numbers
%    rmse     root mean square error of [cal,crossval,pred] (optional)
%    rmsestr  root mean square error text string (optional)
%    st       if zero (0), omit statistics
%
%  Description:
%    This function creates a predicted/measured plot, with some
%    statistics and a regression line.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvpmplot.m,v 1.2 2001/12/04 09:46:01 rune Exp $	

[m,n] = size(pred);
[p,q] = size(meas);

if max(m,n) ~= max(p,q),
  error('vectors must have same size!')
end

if min(m,n) ~= 1 | min(p,q) ~= 1,
  error('input must be vectors!')
end

% select plot character depending of number of objects
if length(meas) > 75,
    plotchar = '.b';
else
    plotchar = 'ob';
end

% plot max and min
pmax   = max(max(pred),max(meas));
pmin   = min(min(pred),min(meas));

% increment for spacing between text lines
txtinc = (pmax-pmin)/12;

% get statistics
[press,sep,rms,slope,bias,offset,r] = mvpmstats(pred,meas);

% slope and offset (y=ax+b)
rmax  = slope*max(meas) + offset;
rmin  = slope*min(meas) + offset;

% print predicted/measured
if num > 0,
    mvnumplot(meas,pred,[],num)
else
    plot(meas,pred,plotchar)
end
hold on
grid on
axis([pmin pmax pmin pmax])
xlabel('Measured');
ylabel('Predicted');

% print target line
plot([pmax pmin],[pmax pmin],':k')
% print trend line
plot([pmax pmin],[rmax rmin],'--m')

if exist('st') == 0 | st ~= 0,
  % print statistics
  txt1=text(pmin+txtinc,pmax-1/2*txtinc,['Objects:      ' num2str(max(m,n))]);
  txt2=text(pmin+txtinc,pmax-2/2*txtinc,['Slope:         ' num2str(slope)]);
  txt3=text(pmin+txtinc,pmax-3/2*txtinc,['Offset:       ' num2str(offset)]);
  txt4=text(pmin+txtinc,pmax-4/2*txtinc,['Bias:           ' num2str(bias)]);
  txt5=text(pmin+txtinc,pmax-5/2*txtinc,['Correlation: ' num2str(r)]);
  txt6=text(pmin+txtinc,pmax-6/2*txtinc,['SEP:           ' num2str(sep)]);

  if exist('rmse'),
    if ~exist ('rmsestr'),
      rmsestr = 'RMSEP';
    end
    txt7=text(pmin+txtinc,pmax-7/2*txtinc,[rmsestr ':    ' num2str(rmse)]);
  else
    txt7=text(pmin+txtinc,pmax-7/2*txtinc,['RMSEP:    ' num2str(rmsep)]);
  end
  
  if exist('lv'),
    txt8=text(pmin+txtinc,pmax-8/2*txtinc,['Latent var.: ' int2str(lv)]);
  end
  
  for i = 1:8,
    set(eval(['txt' int2str(i)]),'FontSize',8);
  end
end

% end of mvpmplot