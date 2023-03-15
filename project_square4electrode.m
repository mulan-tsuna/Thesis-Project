 % function create model and find different voltage from square 4 electrode 
 
 cin_level = '2';
 freq_case = '100Hz';
 cin_case = 'CIN2';
 
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
for i = 1:4
    electrode_geometry{i,:}.cylinder.radius     = 0.5;
end
% square 4 electrode
electrode_geometry{1,:}.cylinder.top_center     = [16.985, 13.247 , 3.05];
electrode_geometry{1,:}.cylinder.bottom_center  = [16.985, 13.247, 3];
   
electrode_geometry{2,:}.cylinder.top_center     = [18.635, 13.247, 3.05];
electrode_geometry{2,:}.cylinder.bottom_center  = [18.635, 13.247, 3];
    
electrode_geometry{3,:}.cylinder.top_center     = [16.985, 11.597, 3.05];
electrode_geometry{3,:}.cylinder.bottom_center  = [16.985, 11.597, 3]; 

electrode_geometry{4,:}.cylinder.top_center     = [18.635, 11.597, 3.05];
electrode_geometry{4,:}.cylinder.bottom_center  = [18.635, 11.597, 3];

fmdl_vh = ng_mk_geometric_models(body_geometry,electrode_geometry);

thickness_CIN1 = 2.9;
rad_CIN1 = 0.5;

thickness_CIN2 = 2.8;
rad_CIN2 = 1;

body_geometry{2}.cylinder.radius        = rad_CIN2;
body_geometry{2}.cylinder.top_center    = [17.81 12.422 3];
body_geometry{2}.cylinder.bottom_center = [17.81 12.422 thickness_CIN2];
body_geometry{2}.name                   = 'cancer';

% Current pattern
stim_pair(1,:)   = [1,4];  

% Measurement pattern
meas_pair(1,:) = [2,3];  

fmdl_vi = ng_mk_geometric_models(body_geometry,electrode_geometry);
  fmdl_vh.nodes = fmdl_vh.nodes/1000;
  fmdl_vi.nodes = fmdl_vi.nodes/1000;

number_current_electrodes = size(electrode_geometry,1);

for i = 1:size(stim_pair,1)  
    fmdl_vh.stimulation(i).stim_pattern= zeros(number_current_electrodes,1);
    fmdl_vh.stimulation(i).stim_pattern(stim_pair(i,1),1) = 1;
    fmdl_vh.stimulation(i).stim_pattern(stim_pair(i,2),1) = -1;
       fmdl_vh.stimulation(i).stim_pattern = fmdl_vh.stimulation(i).stim_pattern/1000;

end

for i = 1:size(stim_pair,1)  
    fmdl_vi.stimulation(i).stim_pattern= zeros(number_current_electrodes,1);
    fmdl_vi.stimulation(i).stim_pattern(stim_pair(i,1),1) = 1;
    fmdl_vi.stimulation(i).stim_pattern(stim_pair(i,2),1) = -1;
     fmdl_vi.stimulation(i).stim_pattern = fmdl_vi.stimulation(i).stim_pattern/1000;

end


for i = 1:size(stim_pair,1)
     fmdl_vh.stimulation(i).meas_pattern = zeros(size(meas_pair,1),number_current_electrodes);
     for j=1:size(meas_pair,1)
         fmdl_vh.stimulation(i).meas_pattern(j,meas_pair(j,1)) = 1;
         fmdl_vh.stimulation(i).meas_pattern(j,meas_pair(j,2)) = -1;
     end
end

for i = 1:size(stim_pair,1)
     fmdl_vi.stimulation(i).meas_pattern = zeros(size(meas_pair,1),number_current_electrodes);
     for j=1:size(meas_pair,1)
         fmdl_vi.stimulation(i).meas_pattern(j,meas_pair(j,1)) = 1;
         fmdl_vi.stimulation(i).meas_pattern(j,meas_pair(j,2)) = -1;
     end
end
eidors_cache('off')
switch upper(freq_case)
    case upper('100Hz')
        cervix_conductivity = 0.05264;
        cancer_conductivity_cin1 = 0.18657; 
        cancer_conductivity_cin2 = 0.25975; 
    case upper('1kHz')
        cervix_conductivity = 0.05368;
        cancer_conductivity_cin1 = 0.18675; 
        cancer_conductivity_cin2 = 0.260014; 
    case upper('10kHz')
        cervix_conductivity = 0.13748;
        cancer_conductivity_cin1 = 0.22075; 
        cancer_conductivity_cin2 = 0.29194; 
    case upper('10e6kHz')
        cervix_conductivity = 0.48537;
        cancer_conductivity_cin1 = 0.39523; 
        cancer_conductivity_cin2 = 0.42360; 
end

cin_level_str = num2str(cin_level);
switch cin_level
    case '1'
      cancer_conductivity = cancer_conductivity_cin1;
    case '2'
      cancer_conductivity = cancer_conductivity_cin2;      
end
% add conductivity in model vh
img_vh = mk_image(fmdl_vh,cervix_conductivity);
vh = fwd_solve(img_vh);

img_vi = mk_image(fmdl_vi,cervix_conductivity);
img_vi.elem_data(fmdl_vi.mat_idx{1,2}) = cancer_conductivity;
vi = fwd_solve(img_vi); 
show_fem(img_vi);

diff_voltage = vh.meas - vi.meas;
% diff_voltageCIN2 = vh.meas - vi.meas;
% diff_voltageCIN1_change = vh.meas - vi.meas;
% diff_voltageCIN2_change = vh.meas - vi.meas;

 
save(['D:\1Reported\4_electrode\change\' 'change_diffVOltage_4square_' cin_case '_' freq_case '.mat']);



