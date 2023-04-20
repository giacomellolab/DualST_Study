function object = MergeSpot(object, feature_name, step)

steps=[1:step:max(object.coordinate(:))];
index_center=find(ismember(object.coordinate(:,1),steps)&ismember(object.coordinate(:,2),steps));

num_spot=size(object.barcode,1);
if isfield(object,'face')
    num_face=size(object.face,1);
end

%%
class_center=knnsearch(object.position(index_center,:),object.position);

for f=1:length(feature_name)
    for i=1:size(index_center,1)
        index_spot=find(class_center==i);
        object.(feature_name{f})(index_spot,:)=ones(length(index_spot),1)*sum(object.(feature_name{f})(index_spot,:));
    end
end


%%
field_name = fieldnames(object,'-full');
for f=1:length(field_name)
    if size(object.(field_name{f}),1)==num_spot
        object.(field_name{f})=object.(field_name{f})(index_center,:);
    elseif isfield(object,'face') && (size(object.(field_name{f}),1)==num_face)
        object.face=Coordinate2Face(round(object.coordinate/step)+1);
    end
end
