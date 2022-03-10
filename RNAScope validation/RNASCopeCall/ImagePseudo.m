clear
close all
mkdir ImagePseudo/Data
files=dir('ImageSubSignal/*tif');
for f=1:numel(files)
    if exist(['ImagePseudo/Data/' files(f).name(1:end-4) '.mat'],'file')
        continue
    end
    load(['Data/ImageSize' files(f).name(1:end-4) '.mat']);
    BlockSize=[40 40];
    Images=dir(['ImageSubOriginal/' files(f).name '/*tif']);

    ImageRNA=cell(ImageNum);
    ImageTissue=cell(ImageNum);
    k=0;
    for Img1=1:ImageNum(1)
        for Img2=1:ImageNum(2)
            k=k+1;
            ImageOriginal=imread(['ImageSubOriginal/' files(f).name '/' Images(k).name]);
            ImageTissueOriginal=CallTissue(ImageOriginal);
            flag=1;
            try
                ImageRNAoriginal=imread(['ImageSubSignal/' files(f).name '/' Images(k).name]);
            catch
                flag=0;
            end
            ImageSize=size(ImageTissueOriginal);
            BlockNum=ceil(ImageSize./BlockSize);

            BlocksOrignal=blockedImage(ImageOriginal,'blocksize',BlockSize);
            BlocksTissue=blockedImage(ImageTissueOriginal,'blocksize',BlockSize);
            ImageTissueTemp=ones([BlockNum 3])*255;
            if flag
                BlocksRNA=blockedImage(ImageRNAoriginal,'blocksize',BlockSize);
                ImageRNAtemp=zeros(BlockNum);
            end
            for Blk1=1:BlockNum(1)
                for Blk2=1:BlockNum(2)
                    BlockOriginal=getBlock(BlocksOrignal,[Blk1,Blk2,1]);
                    BlockTissue=getBlock(BlocksTissue,[Blk1,Blk2]);
                    if sum(BlockTissue(:))~=0
                        BlockOriginal=reshape(BlockOriginal,[numel(BlockTissue) 3]);
                        ImageTissueTemp(Blk1,Blk2,:)=mean(BlockOriginal);
                    end
                    if flag
                        BlockRNA=getBlock(BlocksRNA,[Blk1,Blk2]);
                        if sum(BlockRNA(:))~=0
                            [~,RNAcount]=bwlabel(BlockRNA);
                            ImageRNAtemp(Blk1,Blk2)=RNAcount;
                        end
                    end
                end
            end
            ImageTissue{Img1,Img2}=ImageTissueTemp;
            if flag
                ImageRNA{Img1,Img2}=ImageRNAtemp;
            else
                ImageRNA{Img1,Img2}=zeros(BlockNum);
            end
        end
    end
    ImageRNA=cell2mat(ImageRNA);
    ImageTissue=cell2mat(ImageTissue);
    save(['ImagePseudo/Data/' files(f).name(1:end-4) 'S.mat'],'ImageRNA','ImageTissue');
    save(['ImagePseudo/Data/' files(f).name(1:end-4) 'All.mat'],'ImageRNA','ImageTissue');
end