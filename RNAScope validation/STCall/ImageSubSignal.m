clear
close all
files=dir('ImageSubOriginal/*tif');
for f=1:numel(files)
    Images=dir(['ImageSubOriginal/' files(f).name '/*tif']);
    if exist(['ImageSubSignal/' files(f).name],'file')
        continue
    end
    load(['Data/ColorMap' files(f).name(1:end-4) '.mat']);
    mkdir(['ImageSubSignal/' files(f).name]);
    for i=1:numel(Images)
        if exist(['ImageSubSignal/' files(f).name '/' Images(i).name],'file')
            continue
        end
        ImageRGB=imread(['ImageSubOriginal/' files(f).name '/' Images(i).name]);
        ImageBw=(ImageRGB(:,:,1)==255)&(ImageRGB(:,:,2)==255)&(ImageRGB(:,:,3)==255);
        ImageBw=~ImageBw;
        [ImageLabel,NumCC]=bwlabel(ImageBw);
        if NumCC==0
            continue
        end
        %%
        ImageST=zeros(size(ImageBw));
        Stats=regionprops(ImageLabel,'ConvexImage','BoundingBox');
        BoundingBox=reshape([Stats.BoundingBox],[4 NumCC])';
        BoundingBox=floor(BoundingBox);
        %%
        ImSize=size(ImageRGB);
        DataRgb=reshape(ImageRGB,[prod(ImSize(1:2)) 3]);
        for cc=1:NumCC
            DataRgbCC=mean(DataRgb(ImageLabel==cc,:),1);
            ST=LabelUMI(knnsearch(LabelRGB,DataRgbCC));
            ImageST([BoundingBox(cc,2)+1:BoundingBox(cc,2)+BoundingBox(cc,4)],[BoundingBox(cc,1)+1:BoundingBox(cc,1)+BoundingBox(cc,3)])=(Stats(cc).ConvexImage)*ST;
        end
        ImageST=uint8(ImageST*10);
        imwrite(ImageST,['ImageSubSignal/' files(f).name '/' Images(i).name]);
    end
end