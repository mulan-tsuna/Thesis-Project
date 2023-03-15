%function project_create_model(cin_case)

% ---------------- Create model ------------------

clear; 
close all;
cin_case = 'CIN1_P8';

% % Cervix(LEEP)Model
 body_geometry{1}.intersection(1).cone.top_radius                   = 11;
 body_geometry{1}.intersection(1).cone.top_center                   = [12.5 12.5 0];
 body_geometry{1}.intersection(1).cone.bottom_radius                = 12.5;
 body_geometry{1}.intersection(1).cone.bottom_center                = [12.5 12.5 3];
 body_geometry{1}.intersection(1).elliptic_cylinder.top_center      = [12.5, 12.5, 3];
 body_geometry{1}.intersection(1).elliptic_cylinder.bottom_center   = [12.5, 12.5, 0];           
 body_geometry{1}.intersection(1).elliptic_cylinder.axis_a          = [2.5 0 0];
 body_geometry{1}.intersection(1).elliptic_cylinder.axis_b          = [0 1.5 0];
 body_geometry{1}.intersection(1).elliptic_cylinder.complement_flag = 1;
 body_geometry{1}.max_edge_length                                   = 2;
 body_geometry{1}.name                                      = 'cervix';
 
 % Position of electrode in mm. 
for i = 1:9
    electrode_geometry{i,:}.cylinder.radius     = 0.5;
end

% position 1 st
electrode_geometry{1,:}.cylinder.top_center     = [15.576, 14.509 , 3.05];
electrode_geometry{1,:}.cylinder.bottom_center  = [15.576, 14.509, 3];
   
electrode_geometry{2,:}.cylinder.top_center     = [17.576, 14.509, 3.05];
electrode_geometry{2,:}.cylinder.bottom_center  = [17.576, 14.509, 3];
    
electrode_geometry{3,:}.cylinder.top_center     = [19.576, 14.509, 3.05];
electrode_geometry{3,:}.cylinder.bottom_center  = [19.576, 14.509, 3]; 

electrode_geometry{4,:}.cylinder.top_center     = [15.576, 12.509, 3.05];
electrode_geometry{4,:}.cylinder.bottom_center  = [15.576, 12.509, 3];

electrode_geometry{5,:}.cylinder.top_center     = [17.576, 12.509, 3.05];
electrode_geometry{5,:}.cylinder.bottom_center  = [17.576, 12.509, 3];

electrode_geometry{6,:}.cylinder.top_center     = [19.576, 12.509, 3.05];
electrode_geometry{6,:}.cylinder.bottom_center  = [19.576, 12.509, 3];

electrode_geometry{7,:}.cylinder.top_center     = [15.576, 10.509, 3.05];
electrode_geometry{7,:}.cylinder.bottom_center  = [15.576, 10.509, 3];

electrode_geometry{8,:}.cylinder.top_center     = [17.576, 10.509, 3.05];
electrode_geometry{8,:}.cylinder.bottom_center  = [17.576, 10.509, 3];

electrode_geometry{9,:}.cylinder.top_center     = [19.576, 10.509, 3.05];
electrode_geometry{9,:}.cylinder.bottom_center  = [19.576, 10.509, 3];

fmdl_vh = ng_mk_geometric_models(body_geometry,electrode_geometry);
% show_fem(fmdl_vh);

%create model vi
thickness_CIN1 = 2.9;
rad_CIN1 = 0.5;

thickness_CIN2 = 2.8;
rad_CIN2 = 1;

switch cin_case
    case 'CIN1_P1' %%Only CIN1%%
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [17.576 12.509 3];
        body_geometry{2}.cylinder.bottom_center = [17.576 12.509 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';
    case 'CIN1_P2' 
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [16.579 12.422 3];
        body_geometry{2}.cylinder.bottom_center = [16.579 12.422 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';
    %%9 electrodes position%%
    case 'CIN1_P3'
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [17.576 13.495 3];
        body_geometry{2}.cylinder.bottom_center = [17.576 13.495 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';
     case 'CIN1_P4'
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [16.597 13.495 3];
        body_geometry{2}.cylinder.bottom_center = [16.597 13.495 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';
    case 'CIN1_P5'
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [15.576 13.495 3];
        body_geometry{2}.cylinder.bottom_center = [15.576 13.495 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';
    case 'CIN1_P6'
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [15.576 12.509 3];
        body_geometry{2}.cylinder.bottom_center = [15.576 12.509 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';
     case 'CIN1_P7'
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [20.5 12.509 3];
        body_geometry{2}.cylinder.bottom_center = [20.5 12.509 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';  
     case 'CIN1_P8'
        body_geometry{2}.cylinder.radius        = rad_CIN1;
        body_geometry{2}.cylinder.top_center    = [21.621 12.509 3];
        body_geometry{2}.cylinder.bottom_center = [21.621 12.509 thickness_CIN1];
        body_geometry{2}.name                   = 'cancer';     
        
    case 'CIN2_P1' 
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [17.576 12.51 3];
        body_geometry{2}.cylinder.bottom_center = [17.576 12.51 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';
    case 'CIN2_P2' 
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [16.579 12.422 3];
        body_geometry{2}.cylinder.bottom_center = [16.579 12.422 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';
        
    %%9 electrodes position%%
    case 'CIN2_P3'
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [17.576 13.495 3];
        body_geometry{2}.cylinder.bottom_center = [17.576 13.495 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';
     case 'CIN2_P4'
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [16.597 13.495 3];
        body_geometry{2}.cylinder.bottom_center = [16.597 13.495 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';
    case 'CIN2_P5'
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [15.65 13.55 3];
        body_geometry{2}.cylinder.bottom_center = [15.65 13.55 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';
    case 'CIN2_P6'
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [16.021 12.509 3];
        body_geometry{2}.cylinder.bottom_center = [16.021 12.509 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';  
     case 'CIN2_P7'
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [20.5 12.509 3];
        body_geometry{2}.cylinder.bottom_center = [20.5 12.509 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';    
    case 'CIN2_P8'
        body_geometry{2}.cylinder.radius        = rad_CIN2;
        body_geometry{2}.cylinder.top_center    = [21.621 12.509 3];
        body_geometry{2}.cylinder.bottom_center = [21.621 12.509 thickness_CIN2];
        body_geometry{2}.name                   = 'cancer';     
end

% fmdl_vi = ng_mk_geometric_models(body_geometry,electrode_geometry);
% % show_fem(fmdl_vi);
% 
% number_current_electrodes = size(electrode_geometry,1);

% Current pattern
stim_pair(1,:)   = [1,6];  
stim_pair(2,:)  =  [1,9];
stim_pair(3,:)  =  [1,8];
stim_pair(4,:)  =  [4,3];
stim_pair(5,:)  =  [4,6];
stim_pair(6,:)  =  [4,9];
stim_pair(7,:)  =  [7,2];
stim_pair(8,:)  =  [7,3];
stim_pair(9,:)  =  [7,6];
stim_pair(10,:)  = [8,3];
stim_pair(11,:)  = [8,2];
stim_pair(12,:)  = [9,2];

% Measurement pattern
meas_pair(1,:) = [2,4];  
meas_pair(2,:) = [4,8];
meas_pair(3,:) = [8,6];
meas_pair(4,:) = [6,2];
meas_pair(5,:) = [2,5];
meas_pair(6,:) = [5,3];
meas_pair(7,:) = [5,6];
meas_pair(8,:) = [5,9];
meas_pair(9,:) = [5,8];
meas_pair(10,:) = [5,7];
meas_pair(11,:) = [5,4];
meas_pair(12,:) = [5,1];

fmdl_vi = ng_mk_geometric_models(body_geometry,electrode_geometry);
%  fmdl_vh.nodes = fmdl_vh.nodes/1000;
%  fmdl_vi.nodes = fmdl_vi.nodes/1000;
show_fem(fmdl_vi);

number_current_electrodes = size(electrode_geometry,1);

try
    fmdl_vh = rmfield(fmdl_vh, 'stimulation' );
catch
end

for i = 1:size(stim_pair,1)  
    fmdl_vh.stimulation(i).stim_pattern= zeros(number_current_electrodes,1);
    fmdl_vh.stimulation(i).stim_pattern(stim_pair(i,1),1) = 1;
    fmdl_vh.stimulation(i).stim_pattern(stim_pair(i,2),1) = -1;
    
    
    count = 1;
    j=1;
    
    while count <=size(meas_pair,1)
        if count == 1
            fmdl_vh.stimulation(i).meas_pattern(j,:) = zeros(1,number_current_electrodes);
        end
        if (meas_pair(count,1)==stim_pair(i,1)) || (meas_pair(count,1)==stim_pair(i,2)) || (meas_pair(count,2)==stim_pair(i,1)) || (meas_pair(count,2)==stim_pair(i,2))
        else
            fmdl_vh.stimulation(i).meas_pattern(j,meas_pair(count,1)) = 1;
            fmdl_vh.stimulation(i).meas_pattern(j,meas_pair(count,2)) = -1;
            j=j+1;
        end
        count = count + 1;
    end  
     %fmdl_vh.stimulation(i).stim_pattern = fmdl_vh.stimulation(i).stim_pattern/1000;
end

try
 fmdl_vi = rmfield(fmdl_vi,'stimulation');
catch
end
for i = 1:size(stim_pair,1)  
    fmdl_vi.stimulation(i).stim_pattern= zeros(number_current_electrodes,1);
    fmdl_vi.stimulation(i).stim_pattern(stim_pair(i,1),1) = 1;
    fmdl_vi.stimulation(i).stim_pattern(stim_pair(i,2),1) = -1;
    count = 1;
    j=1;
    
    while count <=size(meas_pair,1)
        if count == 1
            fmdl_vi.stimulation(i).meas_pattern(j,:) = zeros(1,number_current_electrodes);
        end
        if (meas_pair(count,1)==stim_pair(i,1)) || (meas_pair(count,1)==stim_pair(i,2)) || (meas_pair(count,2)==stim_pair(i,1)) || (meas_pair(count,2)==stim_pair(i,2))
        else
            fmdl_vi.stimulation(i).meas_pattern(j,meas_pair(count,1)) = 1;
            fmdl_vi.stimulation(i).meas_pattern(j,meas_pair(count,2)) = -1;
            j=j+1;
        end
        count = count + 1;
    end  
     %fmdl_vi.stimulation(i).stim_pattern = fmdl_vi.stimulation(i).stim_pattern/1000;
end

save(['model_cervix_' cin_case '.mat'])
% -------------------------------------------------------------



