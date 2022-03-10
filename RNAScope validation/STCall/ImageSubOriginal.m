clear
close all
files=dir('ImageOriginal/*tif');
for f=1:numel(files)
    if exist(['ImageSubOriginal/' files(f).name],'file')
        continue
    end
    mkdir(['ImageSubOriginal/' files(f).name])
    RawImage=tiffreadVolume(['ImageOriginal/' files(f).name]);

    RawImageSize=size(RawImage);
    RawImageSize=RawImageSize(1:2);
    ImageSize=[2400 2400];
    ImageNum=round(RawImageSize./ImageSize);
    save(['Data/ImageSize' files(f).name(1:end-4) '.mat'],'ImageNum','RawImageSize','ImageSize');

    BlockImage=blockedImage(RawImage,'BlockSize',[ImageSize 1 3]);
    k=0;
    for i=1:ImageNum(1)
        for j=1:ImageNum(2)
            Image=getBlock(BlockImage,[i j 1 1]);
            ImageSize=size(Image);
            Image=reshape(Image,[ImageSize(1:2) 3]);
            k=k+1;
            imwrite(Image,['ImageSubOriginal/' files(f).name '/' num2str(k,'%03d') num2str(i,'%02d') num2str(j,'%02d') '.tif']);
        end
    end
end