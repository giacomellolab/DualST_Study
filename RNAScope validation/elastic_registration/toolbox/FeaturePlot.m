function FeaturePlot(object,reduction,feature_name,spot_size,flag_mesh,axis_on,flag_colorbar)

if ~exist('reduction','var') || isempty(reduction)
    reduction='position';
end

if ~exist('spot_size','var') || isempty(spot_size)
    spot_size=50;
else
    spot_size(spot_size==0)=.001;
end

if ~isfield(object,'face')
    flag_mesh=0;
elseif ~exist('flag_mesh','var') || isempty(flag_mesh)
    flag_mesh=1;
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
%%

flag_title=0;
if ~exist('feature_name','var') || isempty(feature_name)
    feature_name="green";
    flag_colorbar=0;
end
if strcmp(feature_name,'label') || strcmp(feature_name,'component')
    flag_colorbar=0;
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
if flag_mesh
    triplot(object.face,object.(reduction)(:,2),object.(reduction)(:,1)); hold on
end
scatter(object.(reduction)(:,2),object.(reduction)(:,1),spot_size,spot_color,'filled'); hold on
if flag_colorbar
    colorbar
end
set(gca, 'YDir','reverse');

if isfield(object,'corner')
    scatter(object.(reduction)(object.corner,2),object.(reduction)(object.corner,1),spot_size*1.2,'red','filled');
elseif isfield(object,'fixed_point')
    scatter(object.(reduction)(object.fixed_point,2),object.(reduction)(object.fixed_point,1),spot_size*1.2,'red','filled');
end

axis equal
%%
if axis_on
    xlabel([reduction '-2'],'FontSize',14)
    ylabel([reduction '-1'],'FontSize',14)
else
    axis off
end

if flag_title
    title(feature_name,'FontSize',12);
end

end