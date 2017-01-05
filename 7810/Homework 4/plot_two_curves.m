clc; clear;

%fig 7
file1 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\thin_slab\normal_incidence\no_loss\nrcs_no_loss.mat';
file2 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\thin_slab\normal_incidence\loss\nrcs_loss.mat';

%fig 8
file1 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\thin_slab\grazing_incidence\no_loss\nrcs_no_loss.mat';
file2 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\thin_slab\grazing_incidence\loss\nrcs_loss.mat';

%fig 9
file1 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\thin_slab_inhomogeneous\nrcs_normal_inc.mat';
file2 = 'F:\ceos\courses\Winter2012\Wavefield_imaging\assignment1\results\thin_slab_inhomogeneous\nrcs_grazing_inc.mat';

W_no_loss = open(file1);
W_loss = open(file2);

W1 = W_no_loss.W;
W2 = W_loss.W;

figure(10)
plot(W1(:,1),W1(:,2),'-k', 'LineWidth', 2 )
hold on;
plot(W2(:,1),W2(:,2),'--k', 'LineWidth', 2 )

xlabel( '\phi, degrees' , 'FontSize', 14)
ylabel( 'Echo Width/Wavelength, m' , 'FontSize', 14)
%axis([0 100 0 8]);
axis([0 100 0 4.8]);

%axis([0 100 0 4.8]);

grid on;
set(gca,'XTick', 0:20:100)
%set(gca,'YTick', 0:1:8,'FontSize', 14 )

set(gca,'YTick', 0:0.8:4.8,'FontSize', 14 )
%set(gca,'YTick', 0:4:24,'FontSize', 14 )

%legend('tan \delta=0.0','tan \delta=0.1');
legend('Normal Incidence','Grazing Incidence');
