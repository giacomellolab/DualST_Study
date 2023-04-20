function object = prepare_alignment(object)

[object_comp,object.mesh]=SplitObject(object.mesh);
object.component=object.mesh.component(object.mesh.index);

object.mesh.uv=zeros(size(object.mesh.position));
for i=1:length(object_comp)
    object_comp{i} = conformal_map(object_comp{i},'position');
    object.mesh.uv(object_comp{i}.barcode,:)=object_comp{i}.uv;
end

if length(object_comp)==1
    object.mesh.corner=object_comp{1}.corner;
end

end
