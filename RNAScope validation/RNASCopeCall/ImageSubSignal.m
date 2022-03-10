clear
close all
load Data/Th852540
files=dir('ImageSubOriginal/*tif');
for f=1:numel(files)
    Images=dir(['ImageSubOriginal/' files(f).name '/*tif']);
    if exist(['ImageSubSignal/' files(f).name],'file')
        continue
    end
    mkdir(['ImageSubSignal/' files(f).name]);
    se=strel('disk',3);
    for i=1:numel(Images)
        if exist(['ImageSubSignal/' files(f).name '/' Images(i).name],'file')
            continue
        end
        Image=imread(['ImageSubOriginal/' files(f).name '/' Images(i).name]);
        ImageHSV=rgb2hsv(Image);
        ImageHue=ImageHSV(:,:,1);
        ImageSat=ImageHSV(:,:,2);
        ImageVal=ImageHSV(:,:,3);
        BwHue=(ImageHue>=ThHue);
        BwSat=(ImageSat>=ThSat);
        BwVal=(ImageVal>=ThVal);

        bw1=BwHue.*BwVal;
        bw1=imopen(bw1,se); % filter out small spots

        bw2=BwHue.*BwSat;
        bw2=imopen(bw2,se); % filter out small spots

        ImageMask=bw1|bw2;
        if sum(ImageMask(:))==0
            continue
        end
        ImageRNA=ImageHue.*ImageMask;
        ImageRNA=ImageRNA*255;
        ImageRNA=uint8(ImageRNA);

        imwrite(ImageRNA,['ImageSubSignal/' files(f).name '/' Images(i).name]);
    end
end