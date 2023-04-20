function object = conformal_map(object,assay_name,shape)

% if size(object.(assay_name),2)<3
%     error('low dimension of feature!')
% end

if ~exist('shape','var') || isempty(shape)
    shape='rect';
end

%% chose four corners of rectangle
if (strcmp(shape,'rect') && ~isfield(object,'corner')) || (strcmp(shape,'disk') && ~isfield(object,'fixed_point'))
    if strcmp(shape,'rect')
        num_point=4;
    else
        num_point=1;
    end
    figure
    plot_mesh(object.position(:,[2 1]),object.face,object.color); hold on
    index_point=zeros(num_point,1);
    if num_point==4
        title('Begin with northwest and conter-clockwise!','FontSize',14)
    else
        title('Locate a fixed point!','FontSize',14)
    end
    for i=1:num_point
        [y,x]=ginput(1);
        index_point(i)=knnsearch(object.position,[x,y]);
        x=object.position(index_point(i),1);
        y=object.position(index_point(i),2);
        scatter(y,x,50,'red','filled');
    end
    if num_point==4
        object.corner=index_point;
    else
        object.fixed_point=index_point;
    end
end

%% conformal mapping
if strcmp(shape,'disk')
    uv = disk_conformal_map(object.(assay_name),object.face);
else
    uv = rectangular_conformal_map(object.(assay_name),object.face,object.corner);
end

object.uv=uv;