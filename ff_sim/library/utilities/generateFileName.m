function [fname_png,fname_fig,dirFig] = generateFileName(dir_dpe,formationName,plotName)


dirFig = [dir_dpe,'matlab/Figures/',formationName];
fname = [dirFig,'/',formationName,'_',plotName];
fname_png = [fname,'.png'];
fname_fig = [fname,'.fig'];

end