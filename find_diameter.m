full_file_list = upper({'CIN2_P7_100Hz_2_change','CIN2_P7_1kHz_2_change','CIN2_P7_10kHz_2_change'});
f = 1;
for f = 1:length(full_file_list)
        a = char(full_file_list(f));
        load(a)
        setting.ROI_x = [0.01959,0.02067];
        setting.ROI_y = [0.01178,0.01248];
        setting.ROI_z = [0.002 , 0.003 ];
        setting.only_posval = 1;
        setting.only_negval = 0;
        setting.resolution = 0.1e-3;
        [result_grid, setting] = evaluate_recons(img_recons,setting);
        max(result_grid.accum(:,1));
        find(result_grid.accum==max(result_grid.accum(:,1)));
        mean_position = mean(result_grid.coordinate_max);
        load ('model_cervix_CIN2_P7_change.mat','body_geometry')
        body_geometry{1,2}.cylinder.top_center(:) = body_geometry{1,2}.cylinder.top_center(:)/1000;
        body_geometry{1,2}.cylinder.top_center(1,3) = 0.00295 ;
        diff_position = body_geometry{1,2}.cylinder.top_center - mean_position ;
        save([a '_finddia.mat'])
end

