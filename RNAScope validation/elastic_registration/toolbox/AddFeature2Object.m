function object = AddFeature2Object(object,feature)
%% main principle, assign obj a property named obj.data, that is an extention of feature.data
% compare common barcode
[~,index_object,index_feature]=intersect(object.barcode,feature.barcode);
%% fill in the holes with averaged features

field_name = feature.Properties.VariableNames;
for f=1:length(field_name)
    if iscell(feature.(field_name{f})(1))
        continue
    end
    % initialization
    data=zeros(length(object.barcode),size(feature.(field_name{f}),2));
    data(index_object,:)=feature.(field_name{f})(index_feature,:);

    if size(feature.(field_name{f}),2)>1 && isfield(object,'face')
        index_holes=find(~ismember(object.barcode,feature.barcode));

        adjacency_matrix=compute_adjacency_matrix(object.face);
        adjacency_matrix=boolean(full(adjacency_matrix));

        % main loop
        errors=zeros(1,20);
        for i=1:20
            data_old=data;
            for j=1:length(index_holes)
                is_neighbor=adjacency_matrix(:,index_holes(j));
                data(index_holes(j),:)=mean(data(is_neighbor,:));
            end
            errors(i)=norm(data-data_old,'fro')/norm(data_old(index_holes,:),'fro');
            if errors(i)<1e-4
                break
            end
        end
        object.errors=errors(1:i);
    end
    object.(field_name{f})=data;
end