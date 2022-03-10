function Mask=CallTissue(Image)
hsv=rgb2hsv(Image);
hue=hsv(:,:,1);
sat=hsv(:,:,2);
val=hsv(:,:,3);
Mask=(hue>=.65)&(sat>.15)&(val<.8);
se=strel('disk',3);
Mask=imopen(Mask,se);
