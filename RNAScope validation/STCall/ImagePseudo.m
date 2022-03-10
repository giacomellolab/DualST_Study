clear
close all
files=dir('ImageSubSignal/*tif');
mkdir ImagePseudo/DataTemp
mkdir ImagePseudo/Data
for f=1:numel(files)
    if exist(['ImagePseudo/Data/' files(f).name(1:end-4) '.mat'],'file')
        continue
    end
    if exist(['ImagePseudo/DataTemp/' files(f).name(1:end-4) '.mat'],'file')
        continue
    end 
    load(['Data/ImageSize' files(f).name(1:end-4) '.mat']);
    BlockSize=[40 40];
    Images=dir(['ImageSubOriginal/' files(f).name '/*tif']);

    ImageST=cell(ImageNum);
    k=0;
    for Img1=1:ImageNum(1)
        for Img2=1:ImageNum(2)
            k=k+1;
            ImageOriginal=imread(['ImageSubOriginal/' files(f).name '/' Images(k).name]);
            flag=1;
            try
                ImageSToriginal=imread(['ImageSubSignal/' files(f).name '/' Images(k).name]);
            catch
                flag=0;
            end

            BlocksOrignal=blockedImage(ImageOriginal,'blocksize',BlockSize);
            BlockNum=BlocksOrignal.SizeInBlocks;
            BlockNum=BlockNum(1:2);
            if flag
                BlocksST=blockedImage(ImageSToriginal,'blocksize',BlockSize);
                ImageSTtemp=zeros(BlockNum);
            end
            for Blk1=1:BlockNum(1)
                for Blk2=1:BlockNum(2)
                    BlockOriginal=getBlock(BlocksOrignal,[Blk1,Blk2,1]);
                    if flag
                        BlockST=getBlock(BlocksST,[Blk1,Blk2]);
                        if sum(BlockST(:))~=0
                            ImageSTtemp(Blk1,Blk2)=sum(BlockST(:));
                        end
                    end
                end
            end
            if flag
                ImageST{Img1,Img2}=ImageSTtemp;
            else
                ImageST{Img1,Img2}=zeros(BlockNum);
            end
        end
    end
    ImageST=cell2mat(ImageST);
    try
        load(['../RNAScopeCall/ImagePseudo/Data/' files(f).name(1:end-4) '.mat']);
        save(['ImagePseudo/Data/' files(f).name(1:end-4) '.mat'],'ImageST','ImageRNA','ImageTissue');
    catch
        save(['ImagePseudo/DataTemp/' files(f).name(1:end-4) '.mat'],'ImageST');
    end
end