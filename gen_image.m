function[case_name] = gen_image(case_name,img_recons)

close all
% Top view

figure()
h=show_fem(img_recons,1);
color_edge = 0.35; edge_transparency = 0.15;
FontSize = 9;
set(gcf,'Color','w')
set(0,'DefaultAxesFontName', 'Times New Roman')
set(h,'EdgeColor',[1,1,1]*color_edge);
set(h,'EdgeAlpha',edge_transparency);
xlabel('X');ylabel('Y');zlabel('Z')
title(['amplitude of conductivity = ',num2str(img_recons.calc_colours.clim),' S/m'])
view_angle = [0,90];
view(view_angle(1),view_angle(2));
xlim([0.013 0.022])
ylim([0.008 0.017])
print_convert (['D:\1Project_png\no_noise\svd\change\top_view\change_limC\cut model\' case_name  '.png']);

%side view

figure()
h=show_fem(img_recons,1);
color_edge = 0.35; edge_transparency = 0.15;
FontSize = 9;
set(gcf,'Color','w')
set(0,'DefaultAxesFontName', 'Times New Roman')
set(h,'EdgeColor',[1,1,1]*color_edge);
set(h,'EdgeAlpha',edge_transparency);
xlabel('X');ylabel('Y');zlabel('Z')
title(['amplitude of conductivity = ',num2str(img_recons.calc_colours.clim),' S/m'])
view_angle = [0,0];
view(view_angle(1),view_angle(2));
xlim([0.013 0.022])
print_convert (['D:\1Project_png\no_noise\svd\change\side_view\change_limC\cut model\' case_name  '.png']);

%buttom view

figure()
h=show_fem(img_recons,1);
color_edge = 0.35; edge_transparency = 0.15;
FontSize = 9;
set(gcf,'Color','w')
set(0,'DefaultAxesFontName', 'Times New Roman')
set(h,'EdgeColor',[1,1,1]*color_edge);
set(h,'EdgeAlpha',edge_transparency);
xlabel('X');ylabel('Y');zlabel('Z')
title(['amplitude of conductivity = ',num2str(img_recons.calc_colours.clim),' S/m'])
view_angle = [10,-30];
view(view_angle(1),view_angle(2)); 
print_convert (['D:\1Project_png\no_noise\svd\change\buttom_view\change_limC\' case_name  '.png']);






