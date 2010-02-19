% Script for testing the mvartools package
%	$Id: mvdemo8.m,v 1.2 2001/12/04 07:24:44 rune Exp $	
%
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

% This script demonstrates mvoptlvf

load synthetic.mat

% This is a closed dataset with three components, i.e. the correct
% number of latent variables must be 2.
lv = 8;

[press,cumpress,rmsecv,rmsec,pred,B3d] = ...
    mvcrossval(Xc,y3c,'plsnip',lv,'block',2,0);
%[press,cumpress,rmsecv,rmsec,pred,B3d] = ...
%    mvcrossval(Xc,y3c,'plsnip',lv,'full',[],0);

[b,p,q,w,t,u,inner,xres,yres] = mvplsnipals(mvcenter(Xc),y3c,lv);

optlv = mvoptlv(rmsecv)
%[optlvf,f] = mvoptlvf(press)
