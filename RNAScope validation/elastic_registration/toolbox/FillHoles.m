function [coordinate] = FillHoles(coordinate)
image_size=max(coordinate);
index_old=sub2ind(image_size,coordinate(:,1),coordinate(:,2));

image=zeros(image_size);
image(index_old)=1;
image=boolean(image);
image=imfill(image,4,'holes');
% image=imfill(image,'holes');
index_new = find(image(:));
[x,y]=ind2sub(image_size,index_new);
index_holes=~ismember(index_new,index_old);
coordinate_new=[x,y];
coordinate=[coordinate; coordinate_new(index_holes,:)];
end