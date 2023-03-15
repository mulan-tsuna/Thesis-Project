function [result, setting] = evaluate_recons(img,setting)
% Evaluation images
% By Taweechai Ouypornkochagorn
% Revisions:
% - 20200831 - First launch 
% Parameters:
% - setting
%   o setting.ROI_x, setting.ROI_y, setting.ROI_z 
%   o setting.only_posval, setting.only_negval
%   o setting.resolution 
% Synopsis:
% [~, setting] = evaluate_recons(img_vi); % gen setting
% load(['CIN1_P2_100Hz_1.mat' ]) ******
% [result_grid, setting] = evaluate_recons(img_recons,setting); 

% --- 0. Checking input
display_max_scale = 300; %255
if exist('setting','var') == 0
	setting.ROI_x = [min(img.fwd_model.nodes(:,1)), max(img.fwd_model.nodes(:,1))];
	setting.ROI_y = [min(img.fwd_model.nodes(:,2)), max(img.fwd_model.nodes(:,2))];
	setting.ROI_z = [min(img.fwd_model.nodes(:,3)), max(img.fwd_model.nodes(:,3))];
	setting.only_posval = 1;
	setting.only_negval = 0;
	setting.resolution 	= 1;
	result = nan;
	fprintf('Please recheck generated setting\n')
    return 
end
if isfield(setting,'ROI_x') == 0 || isfield(setting,'ROI_y') == 0  || isfield(setting,'ROI_z') == 0 
	clear error
	error('Please check setting (1)')
end
if length(setting.ROI_x) < 2 || length(setting.ROI_y) <2 || length(setting.ROI_z) <2
	error('Please check setting (2)')
end

if isfield(setting,'only_posval') ==1
	if setting.only_posval == 1
		img.elem_data( img.elem_data < 0) = 0;
	end
end

if isfield(setting,'only_negval') ==1
	if setting.only_negval == 1
		img.elem_data( img.elem_data > 0) = 0;
	end
end

% --- 1. Compute center and prepare grid
img_elems_cen = util_cal_elem_center(img.fwd_model.nodes,img.fwd_model.elems);

grid.x = [setting.ROI_x(1) + setting.resolution /2:setting.resolution : setting.ROI_x(2)]; 
grid.y = [setting.ROI_y(1) + setting.resolution /2:setting.resolution : setting.ROI_y(2)]; 
grid.z = [setting.ROI_z(1) + setting.resolution /2:setting.resolution : setting.ROI_z(2)]; 

accum = zeros(length(grid.x),length(grid.y),length(grid.z));

% --- 2. Find the center
found_elem = 0;
for i=1:size(img_elems_cen,1)
	if 	img_elems_cen(i,1) >= setting.ROI_x(1) && img_elems_cen(i,1) <= setting.ROI_x(2) && ...
		img_elems_cen(i,2) >= setting.ROI_y(1) && img_elems_cen(i,2) <= setting.ROI_y(2) && ...
		img_elems_cen(i,3) >= setting.ROI_z(1) && img_elems_cen(i,3) <= setting.ROI_z(2) 
        found_elem = found_elem +1;
        if mod(found_elem,10) == 0
            fprintf('   Found %d elements...\n',found_elem);
        end
		for x = 1:length(grid.x)
			grid_x_val = grid.x(x);
			for y = 1:length(grid.y)
				grid_y_val = grid.y(y);
				for z = 1:length(grid.z)
					grid_z_val = grid.z(z);
					in = ~isnan(tsearchn(img.fwd_model.nodes,img.fwd_model.elems(i,:),[grid_x_val grid_y_val grid_z_val]));
					if in == 1
						accum(x,y,z) = accum(x,y,z) + img.elem_data(i);
					end
				end
			end
		end
	end
end

index_max = [];
coordinate_max = [];
max_amplitude = max(accum(:));
for x = 1:length(grid.x)
    grid_x_val = grid.x(x);
    for y = 1:length(grid.y)
        grid_y_val = grid.y(y);
        for z = 1:length(grid.z)
            grid_z_val = grid.z(z);
            if accum(x,y,z) == max_amplitude
                index_max = [index_max; x,y,z];
                coordinate_max = [coordinate_max; grid_x_val,grid_y_val,grid_z_val];
            end
        end
    end
end

accum_min = min(accum(:));
accum_max = max(accum(:));
accum = ((accum - accum_min)/(accum_max - accum_min))*display_max_scale;
result.accum = accum;
result.index_max = index_max;
result.coordinate_max = coordinate_max;
result.max_amplitude = max_amplitude;
result.grid_x_resolution = length(grid.x);
result.grid_y_resolution = length(grid.y);
result.grid_z_resolution = length(grid.z);
result.resolution = setting.resolution;
result.setting = setting;
result.coordinate_mean_of_max = mean(coordinate_max);

index_max_elems = [];
for i=1:size(coordinate_max,1)
    temp = 0;
    for j=1:3
        temp = temp + (img_elems_cen(:,j) - coordinate_max(i,j)).^2;
    end
    norm_coordinate = sqrt(temp); 
    min_index = find(norm_coordinate == min(norm_coordinate));
    index_max_elems = [index_max_elems;min_index];
end
result.index_max_elems = [index_max_elems, img.elem_data(index_max_elems,1),img_elems_cen(index_max_elems,:) ]; 
result.elem_center = img_elems_cen;


function test()
load([ 'CIN2_P5_1kHz_2.mat' ])

figure()
show_fem(img_recons);shg; %*****
xlabel('X');ylabel('Y');zlabel('Z')


setting.ROI_x = [0.001583,0.01759];
setting.ROI_y = [0.001346,0.01176];
setting.ROI_z = [0.002 , 0.003 ];
setting.only_posval = 1;
setting.only_negval = 0;
setting.resolution = 0.1e-3;

x = result_raw.CIN2_P7_100Hz_2.img_recons;
y = result_raw.CIN2_P7_1kHz_2.img_recons;
z = result_raw.CIN2_P7_10kHz_2.img_recons;

ab_list = ({'100Hz','1kHz','10kHz'});
for ab=1:length(ab_list)
        case_ab = ab_list{ab};
        switch (case_ab)
            case '100Hz';
                load([ 'CIN2_P5_100Hz_2.mat' ])
                [result_grid, setting] = evaluate_recons(img_recons,setting);   
            case '1kHz' ;
                load([ 'CIN2_P5_1kHz_2.mat' ])
                [result_grid, setting] = evaluate_recons(img_recons,setting);
             case '10kHz';
                 load([ 'CIN2_P5_10kHz_2.mat' ])
                [result_grid, setting] = evaluate_recons(img_recons,setting);
        end
end

function test_display()
%size(result_grid.accum)
max(result_grid_100Hz.accum(:,1));
find(result_grid_100Hz.accum==max(result_grid_100Hz.accum(:,1)));
ans_100Hz = mean(result_grid_100Hz.coordinate_max)

max(result_grid.accum(:,1));
find(result_grid.accum==max(result_grid.accum(:,1)));
ans_1kHz = mean(result_grid.coordinate_max)

max(result_grid_10kHz.accum(:,1));
find(result_grid_10kHz.accum==max(result_grid_10kHz.accum(:,1)));
ans_10kHz = mean(result_grid_10kHz.coordinate_max)


function test_diff_position()
%position 2 CIN 1  
load ('model_cervix_CIN1_P5.mat','body_geometry')

body_geometry{1,2}.cylinder.top_center(1,3) = 2.9 ;
diff_position.CIN2_P7_100Hz.N60DB.T1 = body_geometry{1,2}.cylinder.top_center - ans_100Hz ;


body_geometry{1,2}.cylinder.top_center(1,3) = 2.9 ;
diff_position.result_grid = body_geometry{1,2}.cylinder.top_center - ans_1kHz ;


%body_geometry{1,2}.cylinder.top_center(1,3) = 2.9 ;
%diff_position.CIN2_P7_10kHz.N60DB.T1 = body_geometry{1,2}.cylinder.top_center - ans_10kHz ;

clear 'body_geometry' 'x' 'y' 'z' 'ab_list' 'ab' 'case_ab' 'ans'

save([ 'temp14.mat' ])
clear
%%..............................................................
%%.................................................................


function test_more()
load([ 'temp2.mat' ])
figure()
img_recons.type = 'image'; 
show_fem(result_raw.CIN1_P2_10kHz_1.N30DB.T1.img_recons);shg;
xlabel('X');ylabel('Y');zlabel('Z')
img_recons.elem_data = result_svd.x_delta;
show_fem(img_recons);shg;
clear 'body_geometry' 'diff' 'ans'
save([ 'temp2.mat' ])
clear

function test_useful_function()
% image(result_grid.accum(:,:,2));shg
% number is position of box not position in axis 
temp=reshape(result_grid.accum(:,12,:),[result_grid.grid_x_resolution result_grid.grid_z_resolution]);
temp = imrotate( temp , 90 );
image(temp);shg;
% set(gca,'YTickLabel',[]);
% set(gca,'XTickLabel',[]);
% set(gca,'YTick',[]);
% set(gca,'XTick',[]);

temp=reshape(result_grid.accum(:,:,5),[result_grid.grid_x_resolution result_grid.grid_y_resolution]);
temp = imrotate( temp , 90 );
image(temp);shg;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'YTick',[]);
set(gca,'XTick',[]);

temp=reshape(result_grid.accum(12,:,:),[result_grid.grid_y_resolution result_grid.grid_z_resolution]);
temp = imrotate( temp , 90 );
image(temp);shg;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);


