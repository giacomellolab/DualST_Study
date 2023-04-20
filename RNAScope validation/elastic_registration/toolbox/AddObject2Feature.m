function object = AddObject2Feature(object,feature)
%% compare common barcode
[~,index_object,index_featuer]=intersect(object.barcode,feature.barcode);

%% generate intersected vertex & face
num_spot=size(object.barcode,1);
if isfield(object,'face')
    num_face=size(object.face,1);
end

field_name = fieldnames(object,'-full');
for f=1:length(field_name)
    if size(object.(field_name{f}),1)==num_spot
        object.(field_name{f})=object.(field_name{f})(index_object,:);
    elseif size(object.(field_name{f}),1)==num_face
        object.face=Coordinate2Face(object.coordinate);
    end
end

field_name = feature.Properties.VariableNames;
for f=1:length(field_name)
    object.(field_name{f})=feature.(field_name{f})(index_featuer,:);
end