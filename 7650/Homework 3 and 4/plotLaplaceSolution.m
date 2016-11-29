function plotLaplaceSolution(nx, ny, xmin, xmax, ymin, ymax, T, fig_no, title_string)

dx = (xmax - xmin)/(nx - 1);
dy = (ymax - ymin)/(ny - 1);

x = 0:dx:1;
y = 0:dy:1;

T = reshape(T,nx,ny);
T = T.';

fontsize = 18;
figure(fig_no);
imagesc(x,y,T);
set(gca,'YDir','normal');
view(2)
colorbar;
colormap('hot');
title(title_string,'FontSize',fontsize);
xlabel('x (meters)','FontSize',fontsize);
ylabel('y (meters)','FontSize',fontsize);
set(gca,'FontSize',fontsize);

