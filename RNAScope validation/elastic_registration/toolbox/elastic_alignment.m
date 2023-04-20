function [source, target] = elastic_alignment(source,target)

num_comp=length(unique(source.component));

source.mesh.position_align=zeros(size(source.mesh.position));
flag_int=boolean(zeros(size(source.barcode)));
for i=1:num_comp
    index_source=find(target.mesh.component==i);
    index_target=knnsearch(target.mesh.uv(index_source,:),source.mesh.uv(source.mesh.component==i,:));
    source.mesh.position_align(source.mesh.component==i,:)=target.mesh.position(index_source(index_target),:);

    %% find interior spots
    array=target.mesh.position(target.mesh.index(target.component==i),:);
    index_bd=convhull(array);
    bd=array(index_bd,:);

    flag_int=flag_int | inpolygon(source.mesh.position_align(source.mesh.index,1),source.mesh.position_align(source.mesh.index,2),bd(:,1),bd(:,2));
end
source.mesh.index=source.mesh.index(flag_int);

num_spot=size(source.barcode,1);
field_name = fieldnames(source,'-full');
for f=1:length(field_name)
    if size(source.(field_name{f}),1)==num_spot
        source.(field_name{f})=source.(field_name{f})(flag_int,:);
    end
end
%%
source.mesh.index_align=knnsearch(source.mesh.position_align,target.mesh.position(target.mesh.index,:));

num_spot=size(source.barcode,1);
for f=1:length(field_name)
    if size(source.(field_name{f}),1)==num_spot
        source.([field_name{f} '_align'])=zeros(size(source.mesh.index_align));
    end
end

class_center=knnsearch(source.mesh.position_align(source.mesh.index_align,:),source.mesh.position_align(source.mesh.index,:));
for f=1:length(field_name)
    if size(source.(field_name{f}),1)==num_spot
        if strcmp(field_name{f},'barcode') || strcmp(field_name{f},'position')
            continue
        end
        for i=1:length(target.barcode)
            index_spot=find(class_center==i);
            source.([field_name{f} '_align'])(i,:)=sum(source.(field_name{f})(index_spot,:));
        end
    end
end
end

%%
