function [object_list, object] = SplitObject(object,min_num_spot)
if ~exist('min_num_spot','var')
    min_num_spot=10;
end
%% find connected components in graph, label in order of decreasing area
adjacency_matrix=compute_adjacency_matrix(object.face);
object_graph = graph(adjacency_matrix);
spot_comp = conncomp(object_graph);
comp_label = unique(spot_comp);
num_comp = length(comp_label);
num_spot = zeros(1, num_comp);
for i = 1:num_comp
    num_spot(i) = sum(spot_comp == comp_label(i));
end
[~, order_component] = sort(num_spot, 'descend');

flag_break=0;

object_list=cell(1,num_comp);
object.component=zeros(size(object.barcode));
for i = 1:num_comp
    %% generate mesh using barcode
    indexSplit = find(spot_comp == comp_label(order_component(i)));
    if length(indexSplit)<min_num_spot
        flag_break=1;
        break
    end
    feature=table();
    feature.barcode = object.barcode(indexSplit);
    object.component(indexSplit)=i;
    %%
    object_list{i} = AddObject2Feature(object,feature);
    object_list{i}.face=Coordinate2Face(object_list{i}.coordinate);
end
if flag_break
    object_list=object_list(1:i-1);
else
    object_list=object_list(1:i);
end
