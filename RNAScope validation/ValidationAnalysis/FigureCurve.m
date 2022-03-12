clear
close all
mkdir Figure
%%
ImageName=cell(1,numel(dir('Data/RNA/*mat')));
SideLen=2:2:20;
SideLenMicrometer=SideLen*10;
files=dir('Data/*');
files=[files(3:end)];
LineStyle={'-','--'};
FigName={'Sensitivity','Specificity','PPV','NPV'};
for fig=1:length(FigName)
    j=0;
    for f=1:numel(files)
        images=dir(['Data/' files(f).name '/*.mat']);
        color=hsv(numel(images));
        for i=1:numel(images)
            j=j+1;
            ImageName{j}=[images(i).name(1:end-4)];
            load(['Data/' files(f).name '/' images(i).name]);
            switch FigName{fig}
                case 'Sensitivity'
                    temp=SEN;
                case 'Specificity'
                    temp=SPC;
                case 'PPV'
                    temp=PPV;
                case 'NPV'
                    temp=NPV;
            end
            plot(SideLenMicrometer,temp,'Color',color(i,:),'LineStyle',LineStyle{f},'LineWidth',2,'Marker','o'); hold on
        end
    end
    hold off
    ylabel([FigName{fig} ' (%)'],'FontSize',14);
    xlabel('Block Size (Micrometer)','FontSize',14);
    h=legend(ImageName,'Location','best');
    set(h,'FontSize',12);
    grid on
    print('-dpng',['Figure/FigCurve' FigName{fig} '.png']);
    close all
end