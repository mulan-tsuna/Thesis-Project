
% [vh,vi,img_vh,img_vi,case_name] = project_sim_v('CIN1_P2','100Hz',1);
% 1. change position 2. CIN1-2 3.Hz
% load(['CIN1_P2_10e6kHz_1.mat' ])

batch_id = '14';
file_list1 =  {'CIN1_P1_1kHz_1_change'};
file_list2 =  {'CIN1_P2_1kHz_1_change'};
file_list3 =  {'CIN1_P3_1kHz_1_change'};
file_list4 =  {'CIN1_P4_1kHz_1_change'};
file_list5 =  {'CIN1_P5_1kHz_1_change'};
file_list6 =  {'CIN1_P6_1kHz_1_change'};
file_list7 =  {'CIN1_P7_1kHz_1_change'};
file_list8 =  {'CIN2_P1_1kHz_2_change'};
file_list9 =  {'CIN2_P2_1kHz_2_change'};
file_list10 = {'CIN2_P3_1kHz_2_change'};
file_list11 = {'CIN2_P4_1kHz_2_change'};
file_list12 = {'CIN2_P5_1kHz_2_change'};
file_list13 = {'CIN2_P6_1kHz_2_change'};
file_list14 = {'CIN2_P7_1kHz_2_change'};
switch batch_id
	case '1'
		file_list = file_list1;
	case '2'
		file_list = file_list2;
    case '3'
		file_list = file_list3;
    case '4'
		file_list = file_list4;
    case '5'
		file_list = file_list5;
    case '6'
		file_list = file_list6;
    case '7'
		file_list = file_list7;
    case '8'
		file_list = file_list8;
    case '9'
		file_list = file_list9;
    case '10'
		file_list = file_list10;
    case '11'
		file_list = file_list11;
    case '12'
		file_list = file_list12;
    case '13'
		file_list = file_list13;     
    case '14'
		file_list = file_list14;  
end
 
db_list = upper({'10dB','15dB','20dB','25dB','30dB','35dB', '40dB', '45dB', '50dB', '55dB', '60dB' }); 
num_attempt = 3;
f=14;
for f=1: length(full_file_list)
    file_name = file_list{f};
    load([file_name,'.mat'],'vh','vi','img_vh','img_recons');
    case_name = file_name;
    
    fprintf('--- Running the case %s (%d of %d) ---\n',file_name,f,length(full_file_list))
    for db=1:length(db_list)
        case_dB = db_list{db};
        fprintf('- Case %s (%d of %d) ---\n',case_dB,db,length(db_list))
        
        switch upper(case_dB)
            case upper('10dB')
                noiselev = 0.316;
            case upper('15dB')
                noiselev = 0.178;
            case upper('20dB')
                noiselev = 0.1;
            case upper('25dB')
                noiselev = 0.0562;
            case upper('30dB')
                noiselev = 0.0316;
            case upper('35dB')
                noiselev = 0.0178;
            case upper('40dB')
                noiselev = 0.01;
            case upper('45dB')
                noiselev = 0.00562;
            case upper('50dB')
                noiselev = 0.00316;
            case upper('55dB')
                noiselev = 0.00178;
            case upper('60dB')
                noiselev = 0.001;
        end
        
        for attempt=1:num_attempt
            case_attempt = ['T', num2str(attempt)];
            
            noise = noiselev*std( vh.meas - vi.meas )*randn( size(vi.meas) );
            vi_noise.meas = vi.meas + noise;

            % % %Inversion reconstruction
            figure()
            tic
            preferences_svd.inv_hyperparameter = 1e-6; %*******
            preferences_svd.prior = @prior_tikhonov;
            maxiter_svd = 10;
            fprintf('Start at %s ... \n',datestr(now)); 
            img_recons_noise = img_vh;
            img_recons_noise.type = 'inv_model';
            [result_svd,~]=inv_gn_abs_svd(img_recons_noise,vi_noise.meas ,img_vh.elem_data(),maxiter_svd,preferences_svd,vh);
            fprintf('Finish at %s ... \n',datestr(now)); 
            toc
            resolution = 128;
            img_recons_noise = img_vh;
            img_recons_noise.elem_data = result_svd.x_delta;
            img_recons_noise.calc_colours.clim = img_recons.calc_colours.clim;
            img_recons_noise.calc_colours.ref_level =  0;
            show_fem(img_recons_noise,1); shg;
            result1 = (['result-svd_' case_name, '_' case_dB, '_' case_attempt]); 
            savefig(['D:\1Project_fig\add_noise\' result1 '.fig']);
             
            
            clear i j result1 result2 
            close all
            
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.result_svd=result_svd;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.preferences_svd=preferences_svd;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.img_recons=img_recons;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.vh=vh;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.vi=vi;']); 
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.case_name=case_name;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.case_dB=case_dB;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.case_attempt=case_attempt;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.maxiter_svd=maxiter_svd;']);
            eval(['result_raw.', case_name, '.', 'N' , case_dB, '.', case_attempt,'.vi_noise=vi_noise;']);
           
        end
        switch batch_id
             case '1'
                save('temp1_new.mat','result_raw')
            case '2'
                save('temp2_new.mat','result_raw')
            case '3'
                save('temp3_new.mat','result_raw')
            case '4'
                save('temp4_new.mat','result_raw')
            case '5'
                save('temp5_new.mat','result_raw')
            case '6'
                save('temp6_new.mat','result_raw')
            case '7'
                save('temp7_new.mat','result_raw')
            case '8'
                save('temp8_new.mat','result_raw')
            case '9'
                save('temp9_new.mat','result_raw')
            case '10'
                save('temp10_new.mat','result_raw')
            case '11'
                save('temp11_new.mat','result_raw')
            case '12'
                save('temp12_new.mat','result_raw')
            case '13'
                save('temp13_new.mat','result_raw')
            case '14'
                save('temp14_new.mat','result_raw')         
        end
    end
end
 save(['D:\1Reported\' 'filelist_new_', batch_id '.mat']);