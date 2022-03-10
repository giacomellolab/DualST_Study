clear
close all
mkdir Data/RNA
files=dir('../STCall/ImagePseudo/Data/*mat');
for f=1:numel(files)
    if exist(['Data/RNA/' files(f).name],'file')
        continue
    end
    load(['../STCall/ImagePseudo/Data/' files(f).name]);
    SideLen=2:2:20;
    SEN=zeros(size(SideLen));
    SPC=SEN;
    PPV=SEN;
    NPV=SEN;
    MatConf=cell(size(SideLen));
    for c=1:length(SideLen)
        %% make Tissue binary
        ImageTissueBw=(ImageTissue(:,:,1)==255)&(ImageTissue(:,:,2)==255)&(ImageTissue(:,:,3)==255);
        ImageTissueBw=~ImageTissueBw;
        ImageSize=size(ImageST);
        BlockSize=ones(1,2)*SideLen(c);
        BlockArea=prod(BlockSize);
        %%
        IndHead1=1:BlockSize(1):ImageSize(1);
        IndHead2=1:BlockSize(2):ImageSize(2);

        IndTeil1=0:BlockSize(1):ImageSize(1);
        IndTeil2=0:BlockSize(2):ImageSize(2);
        IndTeil1=IndTeil1(2:end);
        IndTeil2=IndTeil2(2:end);


        SizeInBlock=[min(length(IndHead1),length(IndTeil1)) min(length(IndHead2),length(IndTeil2))];
        %%
        ImageSTnew=zeros(size(ImageST));
        MatST=zeros(SizeInBlock);
        MatRNA=MatST;
        MatTissue=MatST;
        for i=1:SizeInBlock(1)
            for j=1:SizeInBlock(2)
                Ind1=IndHead1(i):IndTeil1(i);
                Ind2=IndHead2(j):IndTeil2(j);
                MatTissue(i,j)=sum(sum(ImageTissueBw(Ind1,Ind2,1)));
                MatST(i,j)=sum(sum(ImageST(Ind1,Ind2)));
                MatRNA(i,j)=sum(sum(ImageRNA(Ind1,Ind2)));
                ImageSTnew(Ind1,Ind2)=sum(sum(ImageST(Ind1,Ind2)));
            end
        end
        MatST=(MatST~=0);
        MatRNA=(MatRNA~=0);
        MatTissue=((MatTissue/BlockArea)>.05)|MatST|MatRNA;
        MatTissue=((MatTissue)~=0);

        NumST=sum(MatST(:));
        NumRNA=sum(MatRNA(:));
        NumTRNAe=sum(MatTissue(:));

        TP=sum(sum(MatST&MatRNA));
        FP=NumST-TP; % False Positve: ST positive but RNAScope negative
        FN=NumRNA-TP; % vice versa
        TN=NumTRNAe-sum([TP FP FN]);

        MatConf{c}=[TP FP; FN TN];
        SEN(c)=TP/(TP+FN)*100;
        SPC(c)=TN/(TN+FP)*100;
        PPV(c)=TP/(TP+FP)*100;
        NPV(c)=TN/(TN+FN)*100;
    end
    save(['Data/RNA/' files(f).name],'NPV','PPV','SPC','SEN','MatConf');
end