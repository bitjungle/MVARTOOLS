function mvregplot(figname,figinfo)
%MVREGPLOT -- add legend with filename and date
%
%  Usage:
%    mvregplot(figname,figinfo)
%  
%  Inputs:
%    figname    is a string. In principle this can be any string.
%               In customary use, one supplies the name of the script
%               file generating the current display.
%    figinfo    is a string containing 'extra' figure info, e.g the
%               authors initials
%
%  Description:
%    Write figure info below the x axis. The current date (in ISO
%    format) will also be printed to the figure.
%
%  Copying:
%    MVARTOOLS, Copyright (C) 1999-2001 Rune Mathisen <mvartools@bitjungle.com>
%    MVARTOOLS comes with ABSOLUTELY NO WARRANTY; for details type 
%    `mvwarranty'. This is free software, and you are welcome to 
%    redistribute it under certain conditions; type `mvcopying' for 
%    details. For more information on MVARTOOLS, type 'mvreadme'.

%	$Id: mvregplot.m,v 1.2 2001/12/04 10:02:14 rune Exp $	

t = clock;
isodate = [ ...
	sprintf('%d',t(1)), ...                        % year
	strrep( sprintf('-%2d',t(2)), ' ', '0'), ...   % month
	strrep( sprintf('-%2d',t(3)), ' ', '0')        % date
    ];

axes('Position',[.01 .01 .98 .05],'Visible','off');
h1 = text(.05,.5,figname); 
h2 = text(.78,.5,isodate);
h3 = text(.92,.5,figinfo);
set(h1,'FontSize',9);
set(h2,'FontSize',9);
set(h3,'FontSize',9);

% end of registerplot
