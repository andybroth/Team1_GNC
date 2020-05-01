function [] = save_figures(dir_dpe,formationName,plotName,gcf)

[fname_png,fname_fig,dirFig] = generateFileName(dir_dpe,formationName,plotName);

if ~exist(dirFig,'dir')
    mkdir(dirFig);
end

saveas(gcf,fname_png);
saveas(gcf,fname_fig);

end
