function [vh,vi,img_recons,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name)
%     function [vh,vi,img_recons,img_temp,preferences_krylov,preferences_svd,case_name] = project_reconstruction(vh,vi,img_vh,img_vi,case_name)
    figure()
    tic
    preferences_svd.inv_hyperparameter = 1e-6; %*******
    preferences_svd.prior = @prior_tikhonov;
    maxiter_svd = 10;
    fprintf('Start at %s ... \n',datestr(now)); 
    img_recons = img_vh;
    img_recons.type = 'inv_model';
    [result_svd,~]=inv_gn_abs_svd(img_recons,vi,img_vh.elem_data(),maxiter_svd,preferences_svd,vh);
    fprintf('Finish at %s ... \n',datestr(now)); 
    fprintf(case_name); 
    toc
    resolution = 128;
    img_recons = img_vh;
    img_recons.elem_data = result_svd.x_delta;
%      if case_name(4) == '1' 
%          img_recons.calc_colours.clim = 0.04;
%      elseif  case_name(4) == '2' 
%          img_recons.calc_colours.clim = 0.25;
%      end
    img_recons.calc_colours.ref_level =  0;
    show_fem(img_recons,1); shg;
    result1 = (['result-svd_' case_name ]); 
    savefig(['D:\1Project_fig\No_noise\svd\no_change\nolimC\10kHz\' result1 '.fig']);

    % % % % %........................................................................
%     figure()
%     [Reg] = iso_f_smooth2(img_vh.fwd_model.elems,img_vh.fwd_model.nodes,3,1);
%     RtR = Reg'*Reg;
%     save('D:\temp\prior_cervix.mat','Reg','RtR');
%     preferences_krylov = gen_preferences('NEWTON-KRYLOV','none','smooth','none','none','none');
%     maxiter = 15;
%     preferences_krylov.convergence_tolerence = 1e-5;
%     preferences_krylov.linear_gmres = 0; 
%     preferences_krylov.no_of_subspace = 400; %** krylov
%     preferences_krylov.internal_RegParam = 1e-8; % krylov 10
%     preferences_krylov.inv_hyperparameter = 1e-6; %******* 8
%     preferences_krylov.max_inv_hyperparameter = 1e-3;
%     prior_file = 'D:\temp\prior_cervix.mat';
%     preferences_krylov.load_Reg_file = prior_file;
%     preferences_krylov.load_RtR_file = prior_file;
%     maxiter_krylov = 15;
%     tic
%     fprintf('Start at %s ... \n',datestr(now)); 
%     [result_krylov,~]=inv_newton_krylov_abs6_pjm(img_vh,vi,img_vh.elem_data(),preferences_krylov.preset_linear_estimation,preferences_krylov.no_of_subspace,preferences_krylov.internal_RegParam,maxiter_krylov,preferences_krylov,[]); 
%     fprintf('Finish at %s ... \n',datestr(now)); 
%     toc
%     img_temp = img_vh;
%     img_temp.elem_data = result_krylov.x_delta;
% 
%      if case_name(4) == '1' 
%          img_temp.calc_colours.clim = 0.032;
%      elseif  case_name(4) == '2' 
%          img_temp.calc_colours.clim = 0.2;
%      end
% 
%     img_temp.calc_colours.ref_level =  0;
%     show_fem(img_temp,1);shg;
%     result2 = (['result-krylov' case_name]);
%     savefig(['D:\1Project_fig\No_noise\krylov\' result2 '.fig']);
%     print_convert (['D:\1Project_png\krylov\' result2 '.png']);
% max_vi = max(abs(vi.meas));
% min_vi = min(abs(vi.meas)) ;
% max_diff = max(abs(vh.meas -vi.meas)) ;
% min_diff = min(abs(vh.meas-vi.meas));
    clear i j result1 result2 
    save(['D:\1Reported\no_noise\no_change\nolimc\10kHz\' case_name '.mat']);
 

    