function object = Visium2Object(path,flag_fillholes,flag_rename,flag_addin)

rawdata=readtable([path '/tissue_positions_list.csv']);
image=imread([path '/tissue_lowres_image.png']);
scale=importdata([path '/scalefactors_json.json']);
scale=jsondecode(scale{1});
scale=scale.tissue_lowres_scalef;

%%
if ~exist('flag_fillholes','var')
    flag_fillholes=1;
end

if ~exist('flag_addin','var')
    flag_addin=0;
else
    flag_fillholes=1;
end

index_tissue=find(boolean(rawdata.Var2));

coordinate_all=table2array(rawdata(:,{'Var3','Var4'}))+1;

coordinate_all(:,2) = floor(coordinate_all(:,2)/2) + ceil(coordinate_all(:,1)/2); % very important pos2sub

%% add in
if flag_addin
    temp.coordinate=coordinate_all(index_tissue,:);
    temp.face=Coordinate2Face(temp.coordinate);

    FeaturePlot(temp,'coordinate',[],[],1);
    pause;

    addindlg=inputdlg('Please enter addin number','Add-In',[1 20]);
    count_max=str2num(cell2mat(addindlg));
    choice='Yes';

    index_spot_new=zeros(20,1); count=0;
    for i=1:length(index_spot_new)
        if i>count_max
            choice = questdlg('Continue to add in？', ...
                'Add-In',...
                'Yes', 'No', 'Exit');
        end
        switch choice
            case 'Yes'
                count=count+1;
                [y,x]=ginput(1);
                index_spot_new(i)=knnsearch(coordinate_all,[x,y]);
                x=coordinate_all(index_spot_new(i),1);
                y=coordinate_all(index_spot_new(i),2);
                scatter(y,x,50,'red','filled');
            case 'No'
                break;
            case 'Exit'
                break;
        end
    end
    index_spot_new=index_spot_new(1:count);
    index_tissue=[index_tissue; index_spot_new];
end

%% fill holes
if flag_fillholes
    coordinate_new=FillHoles(coordinate_all(index_tissue,:));
    [~,index_tissue]=intersect(coordinate_all,coordinate_new,'rows');
end

%%
coordinate=coordinate_all(index_tissue,:);
position=table2array(rawdata(index_tissue,{'Var5','Var6'}));
barcode=table2cell(rawdata(index_tissue,{'Var1'}));
if exist('flag_rename','var') && ~isempty(flag_rename)
    for i=1:length(barcode)
        barcode{i}=[num2str(flag_rename) '_' barcode{i}];
    end
end
face=Coordinate2Face(coordinate);

%% sort position & face in alphabet order
[object.barcode, order_alphabet] = sort(barcode);
[~, sort_face] = sort(order_alphabet);
object.coordinate = coordinate(order_alphabet, :);
object.position = position(order_alphabet, :);
object.face = sort_face(face);

object.image=image;
object.scale=scale;

end