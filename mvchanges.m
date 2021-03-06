echo on
% MVARTOOLS
% For use with MATLAB (and OCTAVE)
% Copyright (c) 1999-2001 -- Rune Mathisen <mvartools@bitjungle.com>
% MVARTOOLS comes with ABSOLUTELY NO WARRANTY; 
% for details type `mvwarranty'.
% See the ChangeLog for detailed info on changes.
%
% Version 1.2.1 - 2001-12-16
% ---------------------------------
% Added new function mvobjcenter.m (RM).
% Temporary (?) bug-fix in mvnumplot.m (RM).
% Misc. fixes/changes in mvpcanipals.m,
% mvfullpredict.m and mvrpls.m (RM).
%
% Version 1.2 - 2001-12-04
% ---------------------------------
% Added new functions mvplsnipcore.m and mvplsregcoeff.m (RM).
% Rewrote mvplsnipals.m, removed mvpls2nipals.m (RM).
% Fixed errors in mvdemo9 and mvtest (RM). 
% Removed unfinished functions mvrplsc.m and mvrplscs.m (RM).
% Misc. other fixes.
% Moved the source tree to a CVS repository (RM).
%
% Version 1.1.1 - 2001-05-08
% ---------------------------------
% Fixes in mvrpls.m (RM)
% New functions: mvrplsc.m and mvrplscs.m (not finished) (RM).
% Added some updates from 1.0.6 that was forgotten in 1.1.0 (RM).
% Added mvtest.m (also forgotten in 1.1.0). Added all new functions (RM).
% Changed mvsynthetic.m (and the synthetic dataset) (RM).
% Bug-fix in mvremnan.m (RM).
% Removed the html pages from the distribution (RM).
% distdata.mat is now in Matlab V4 format (RM).
%
% Version 1.1.0 - 2001-04-16
% ---------------------------------
% This is a beta version! Functions may be broken!
% New functions: 
%                mvabstrans.m     mvtransabs.m
%                mvedist.m        mvmdist.m
%                mvpls2nipals.m   mvrpls.m
%                mvoptlvf.m
%                mvdensityplot.m
%                mvdigfilt.m
%                mvremnan.m
%                mvmeansmooth.m
%                + four new demo scripts
% Removed functions:  
%                mvmahalanobis.m  mvmdistscores.m
% The synthetic dataset has changed (generating script is enclosed).
%
% Version 1.0.6 - 2001-04-16
% ---------------------------------
% Added script for testing all functions (mvtest.m) (RM).
% Fixed bugs in mvaddsine, mvaddslope, mvrevarscale and mvmedsmooth (RM).
% Misc. minor changes (mostly documentation changes) (RM).
%
% Version 1.0.5 - 2001-04-12
% ---------------------------------
% Bug-fix in mvcrossval.m (RM).
% Change in mvpmplot.m: plot character dependant on num. of objects (RM).
% Fixed documentation in mvcenter.m (RM).
% Added a new demo-script (RM).
% Misc. minor changes (mostly documentation changes) (RM).
%
% Version 1.0.4 - 2001-02-12
% ---------------------------------
% Improved mvscoreplot.m (RM).
% Bug-fix and improvements in mvffdesign.m (RM).
% New demo-script (RM).
% MVARTOOLS logo! (RM).
%
% Version 1.0.3 - 2001-01-26
% ---------------------------------
% The mvcenter.m function now accepts two input arguments (RM).
% Removed mvcenternew.m (RM).
% The mvvarscale.m function now accepts two input arguments (RM).
% Implemented block and random validation in mvcrossval.m (RM).
% Changed mvcvbyclass.m to make it work in MVARTOOLS (RM).
% Misc. minor bug fixes (mostly documentation changes) (RM).
%
% Version 1.0.2 - 2001-01-09
% ---------------------------------
% Fixed bug in mvplsnipals.m (RM).
% Removed PLS2-support in mvplsnipals.m, implement in version 1.1 (?) (RM).
% Convergence criteria in mvpcanipals.m is now a function of eps. (RM)
%
% Version 1.0.1 - 2000-12-09
% ---------------------------------
% New email and Web address.
% New function: mvfullpredict.m (RM).
% New function: mvsavgol.m (RM/KH).
% Bug-fix in mvcrossval.m, RMSEC (RM).
% Some minor bug fixes (RM).
%
% Version 1.0.0 - 2000-03-12
% ---------------------------------
% First release version!
%
% Version 1.0.0-beta1 - 1999-09-07
% ---------------------------------
% Development has started again! Fixed broken demo scripts, and a
% small buq fix in mvcrossval. Changes by RM.
%
% Version 1.0.0-alpha3 - 1999-04-19
% ---------------------------------
% A lot of bug-fixes again. Many functions have changed I/O syntax,
% to make them more consistent. Much improved validation functions,
% and a new one added (cross-validation by class). New functions
% for re-centering and re-scaling of variables. All changes by RM.
%
% Version 1.0.0-alpha2 - 1999-04-08
% ---------------------------------
% L ts of bug fixes and improvements; most noticeably in mvpcrsvd
% and mvcrossval (all by RM). A new function for full factorial
% experimental design (by VBG).
%
% Version 1.0.0-alpha1 - 1999-04-05
% ---------------------------------
% First alpha release (all alpha versions will have a very limited
% distribution).
%
echo off
