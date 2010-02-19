%	$Id: mvdemo9.m,v 1.3 2001/12/03 11:54:55 rune Exp $	
% Script for testing the mvartools package
%
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

% This script demonstrates RPLS

load synthetic.mat

maxlv = 4;
uselv = 3;
mem1 = 0.5;
mem2 = 0.9;
mem3 = 1.0;

[m,n]=size(Xv);
Xval = zeros(m,n);

mult = linspace(0.0001,0.2,m);
base = linspace(0.001,0.4,m/2);

for k=1:m,
  Xval(k,:) = mvaddslope(Xv(k,:),1,mult(k));
end
for k=((m/2)+1):m,
  Xval(k,:) = Xv(k,:)+base(k-m/2);
end

% initial model
[Xcent,xmean] = mvcenter(Xc);
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcent,y1c,maxlv);
for h=1:m,
  Xnew = mvcenter(Xval(h,:),xmean);
  ypred1(h) = mvpredict(Xnew,b,uselv);
end

for h=1:m,
  Xnew = mvcenter(Xval(h,:),xmean);
  ypred2a(h) = mvpredict(Xnew,b,uselv);
  [b,p,w,t,u,inner,X,y] = mvrpls(Xnew,y1v(h),p,t,inner,maxlv,mem1);
end

[Xcent,xmean] = mvcenter(Xc);
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcent,y1c,maxlv);
for h=1:m,
  Xnew = mvcenter(Xval(h,:),xmean);
  ypred2b(h) = mvpredict(Xnew,b,uselv);
  [b,p,w,t,u,inner,X,y] = mvrpls(Xnew,y1v(h),p,t,inner,maxlv,mem2);
end

[Xcent,xmean] = mvcenter(Xc);
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcent,y1c,maxlv);
for h=1:m,
  Xnew = mvcenter(Xval(h,:),xmean);
  ypred2c(h) = mvpredict(Xnew,b,uselv);
  [b,p,w,t,u,inner,X,y] = mvrpls(Xnew,y1v(h),p,t,inner,maxlv,mem3);
end

Xcal = Xc;
ycal = y1c;
[Xcent,xmean] = mvcenter(Xcal);
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcent,y1c,maxlv);
for h=1:m,
  Xnew = mvcenter(Xval(h,:),xmean);
  ypred3(h) = mvpredict(Xnew,b,uselv);
  Xcal = [Xcal; Xval(h,:)];
  ycal = [ycal; y1v(h,:)];
  [Xcent,xmean] = mvcenter(Xcal);
  [b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcent,ycal,maxlv);
end

Xcal = Xc;
ycal = y1c;
[Xcent,xmean] = mvcenter(Xcal);
[b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcent,y1c,maxlv);
for h=1:m,
  Xnew = mvcenter(Xval(h,:),xmean);
  ypred4(h) = mvpredict(Xnew,b,uselv);
  Xcal = [Xcal(2:end,:); Xval(h,:)];
  ycal = [ycal(2:end); y1v(h)];
  [Xcent,xmean] = mvcenter(Xcal);
  [b,p,q,w,t,u,inner,Xres,yres] = mvplsnipals(Xcent,ycal,maxlv);
end

disp('Test completed, now plotting the results...')

figure
plot(ypred1'-y1v,'k')
hold on
plot(ypred2a'-y1v,'b')
plot(ypred2b'-y1v,'m')
plot(ypred2c'-y1v,'g')
plot(ypred3'-y1v,'c')
plot(ypred4'-y1v,'r')
legend('static','rpls 0.5','rpls 0.9','rpls 1.0','growing','moving')
xlabel('samples (time)')
ylabel('error')
