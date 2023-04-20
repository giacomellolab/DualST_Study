function face=Coordinate2Face(coordinate)
image_size=max(coordinate);
index_coordinate=sub2ind(image_size,coordinate(:,1),coordinate(:,2));

%% vertex
m=image_size(1);
n=image_size(2);
index_vertex=[1:m*n]';

%% face
% form rectangular grid
rectangle=[index_vertex index_vertex+1 index_vertex+(m+2)  index_vertex+m+1]; % original, south, northeast, diagonal
flag_rectangle=ismember(rectangle,index_coordinate);

% find triangle in region
triangle_1=rectangle(:,[1 2 4]);
num_vertex_1=sum(flag_rectangle(:,[1 2 4]),2);

triangle_2=rectangle(:,[2 3 4]);
num_vertex_2=sum(flag_rectangle(:,[2 3 4]),2);

face=[triangle_1(num_vertex_1==3,:); triangle_2(num_vertex_2==3,:)];
[~,face]=ismember(face,index_coordinate);
