function object = CreatImageMesh(object,transp)

imsize=size(object.bw);
index_coordinate=find(object.bw);
[x,y]=ind2sub(imsize,index_coordinate);
object.mesh.coordinate=[x,y];
object.mesh.position=object.mesh.coordinate;
object.mesh.barcode=(1:length(x))';

color=double(reshape(object.image,[prod(imsize) 3]));
object.mesh.color=color(index_coordinate,:)/max(color(:));

if transp
    object.mesh.color=object.mesh.color*(1-transp)+transp;
end

object.mesh.face=Coordinate2Face(object.mesh.coordinate);
%%
object.mesh.index=knnsearch(object.mesh.position,object.position*object.scale);



end