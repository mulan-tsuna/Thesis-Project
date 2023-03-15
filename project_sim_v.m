function [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v(cin_case,freq_case,cin_level)
% Example :
% [vh,vi,img_vh,img_vi,case_name] = project_sim_v('CIN_P8','1kHz',1);


%  show_fig = 1;
%  save_fig = 1;
%  save_png = 1;
%  cin_case = 'CIN1_P1';  
%  freq_case = '1kHz'; %***
%  cin_level = 1; %***

%unit = 'V';
unit = 'mV';
if strcmp(unit,'V')==1
    file_prefix = 'change_';
    fprintf('Using V case\n');
else
    file_prefix = '';
    fprintf('Using mV case\n');
end

switch cin_case
    case 'CIN1_P1'
         load([file_prefix 'model_cervix_' cin_case '.mat'])
    case 'CIN1_P2'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN1_P3'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN1_P4'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN1_P5'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN1_P6'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN1_P7'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN1_P8'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
         
    case 'CIN2_P1'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN2_P2'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN2_P3'
         load([file_prefix 'model_cervix_' cin_case '.mat'])
    case 'CIN2_P4'
         load([file_prefix 'model_cervix_' cin_case '.mat']) 
    case 'CIN2_P5'
         load([file_prefix 'model_cervix_' cin_case '.mat'])      
    case 'CIN2_P6'
         load([file_prefix 'model_cervix_' cin_case '.mat'])      
    case 'CIN2_P7'
         load([file_prefix 'model_cervix_' cin_case '.mat'])      
    case 'CIN2_P8'
         load([file_prefix 'model_cervix_' cin_case '.mat'])      
end

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
% code to find conctivity (2.831)/(1+i*(1e4/15e3))+2.529
cin_level_str = num2str(cin_level);
switch cin_level
    case '1'
      cancer_conductivity = cancer_conductivity_cin1;
    case '2'
      cancer_conductivity = cancer_conductivity_cin2;      
end

case_name = [cin_case '_' freq_case '_' cin_level_str '_nochange' ];
eidors_cache('off')

% add conductivity in model vh
img_vh = mk_image(fmdl_vh,cervix_conductivity);
vh = fwd_solve(img_vh);

% add conductivity in model vi
img_vi = mk_image(fmdl_vi,cervix_conductivity);
img_vi.elem_data(fmdl_vi.mat_idx{1,2}) = cancer_conductivity;
vi = fwd_solve(img_vi);

%find min, max, different voltage
max_vi = max(abs(vi.meas));
min_vi = min(abs(vi.meas)) ;
max_diff = max(abs(vh.meas -vi.meas)) ;
min_diff = min(abs(vh.meas-vi.meas));
diff_Voltage = abs(vh.meas-vi.meas);
diff_Voltage_noabs = vh.meas-vi.meas;



 
