function FeaturePlotMesh(object,reduction,feature_name,spot_size,flag_feature,axis_on,flag_colorbar)

if ~exist('reduction','var') || isempty(reduction)
    reduction='position';
end

if ~exist('spot_size','var') || isempty(spot_size)
    spot_size=50;
else
    spot_size(spot_size==0)=.001;
end

if ~isfield(object.mesh,'face')
    object.mesh.face=Coordinate2Face(object.mesh.coordinate(:,:));
end

if ~exist('axis_on','var') || isempty(axis_on)
    if strcmp(reduction,'position')
        axis_on=0;
    else
        axis_on=1;
    end
end

if ~exist('flag_colorbar','var') || isempty(flag_colorbar)
    flag_colorbar=1;
end
if strcmp(feature_name,'label') || strcmp(feature_name,'component')
    flag_colorbar=0;
end
%%

flag_title=0;
if ~exist('feature_name','var') || isempty(feature_name)
    feature_name="green";
end

if isstring(feature_name)
    spot_color=feature_name;
    flag_colorbar=0;
else
    spot_color=object.(feature_name);
    flag_title=1;
end
if size(spot_color,2)==3
    flag_colorbar=0;
end

%%
plot_mesh(object.mesh.(reduction)(:,[2 1]),object.mesh.face,object.mesh.color); hold on
if flag_feature
    scatter(object.mesh.(reduction)(object.mesh.index,2),object.mesh.(reduction)(object.mesh.index,1),spot_size,spot_color,'filled'); hold on
    colormap("parula")
end

if flag_colorbar && flag_feature
    colorbar
end
set(gca, 'YDir','reverse');

if isfield(object.mesh,'corner')
    scatter(object.mesh.(reduction)(object.mesh.corner,2),object.mesh.(reduction)(object.mesh.corner,1),spot_size*1.2,'red','filled');
elseif isfield(object.mesh,'fixed_point')
    scatter(object.mesh.(reduction)(object.mesh.fixed_point,2),object.mesh.(reduction)(object.mesh.fixed_point,1),spot_size*1.2,'red','filled');
end

axis equal
%%
if axis_on
    xlabel([reduction '-2'],'FontSize',14)
    ylabel([reduction '-1'],'FontSize',14)
else
    axis off
end

if flag_title && flag_feature
    title(feature_name,'FontSize',12);
end

end