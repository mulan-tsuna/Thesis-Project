
file_list1 =  {'CIN1_P1','CIN1_P2','CIN1_P3','CIN1_P4','CIN1_P5','CIN1_P6','CIN1_P7','CIN1_P8','CIN2_P1','CIN2_P2','CIN2_P3','CIN2_P4','CIN2_P5','CIN2_P6','CIN2_P7','CIN2_P8'};
f = 1;
for f = 1:length(file_list1)
    if f == 1
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN1_P1','10kHz','1');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 2
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN1_P2','10kHz','1'); 
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 3
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN1_P3','10kHz','1');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 4
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN1_P4','10kHz','1');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 5
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN1_P5','10kHz','1');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 6  
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN1_P6','10kHz','1');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 7
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN1_P7','10kHz','1'); 
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
%     elseif f == 8
%         [vh,vi,img_vh,img_vi,case_name] = project_sim_v('CIN1_P8','10kHz','1');
%         [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
%         [case_name] = gen_image(case_name,img_recons);
%         clear
%         close all
    elseif f == 9
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN2_P1','10kHz','2'); 
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 10
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN2_P2','10kHz','2');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 11
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN2_P3','10kHz','2');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
    elseif f == 12
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN2_P4','10kHz','2'); 
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons);
        clear
        close all
     elseif f == 13
         [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN2_P5','10kHz','2');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons); 
        clear
         close all
     elseif f == 14
         [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN2_P6','10kHz','2');
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons) ;
        clear
         close all
     elseif f == 15
        [vh,vi,img_vh,img_vi,case_name,max_vi,min_vi,max_diff,min_diff] = project_sim_v('CIN2_P7','10kHz','2'); 
        [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
        [case_name] = gen_image(case_name,img_recons); 
        clear
        close all
%      elseif f ==16
%          [vh,vi,img_vh,img_vi,case_name] = project_sim_v('CIN2_P8','10kHz','2');
%         [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name);
%         [case_name] = gen_image(case_name,img_recons); 
%         clear
%          close all
    end
end
 
