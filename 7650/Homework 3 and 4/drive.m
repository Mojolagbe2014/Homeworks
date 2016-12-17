
close all; clc;
sIdx = 6;
%% show the convergence plot
figure(1);
leg = {['Block Jacobi            - ', num2str(bs(1))], ['Block Gauss-Seidel - ', num2str(bs(1))]};
if sIdx > length(bs) || sIdx < 1; sIdx = length(bs); end
if sIdx == 1; semilogy(1:iter_ju{1}, err_ju{1},'LineWidth', 1.5); 
else semilogy(1:iter_ju{1}, err_ju{1}, '--','LineWidth', 1.5);
end
hold on
semilogy(1:iter_gu{1}, err_gu{1},'LineWidth', 1.5)
for i = 2:sIdx
    semilogy(1:iter_ju{i}, err_ju{i}, '--','LineWidth', 1.5)
    semilogy(1:iter_gu{i}, err_gu{i}, 'LineWidth', 1.5);
    leg = [leg ['Block Jacobi            - ', num2str(bs(i))], ['Block Gauss-Seidel - ', num2str(bs(i))]];
end
legend(leg);
title(['Convergence for ', num2str(dim),'x', num2str(dim), ' Matrix (Unpermuted)']);
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
set(gca,'FontSize',fontsize);

figure(2);
leg = {['Block Jacobi (BFS)            - ', num2str(bs(1))], ['Block Gauss-Seidel (BFS) - ', num2str(bs(1))], ['Block Jacobi (RCM)            - ', num2str(bs(1))], ['Block Gauss-Seidel (RCM) - ', num2str(bs(1))]};
if sIdx == 1; semilogy(1:iter_jb{1}, err_jb{1}, 'LineWidth', 1.5); hold on; semilogy(1:iter_jr{1}, err_jr{1},'LineWidth', 1.5);
else semilogy(1:iter_jb{1}, err_jb{1}, '--','LineWidth', 1.5); hold on; semilogy(1:iter_jr{1}, err_jr{1}, '--','LineWidth', 1.5);
end

semilogy(1:iter_gb{1}, err_gb{1},'LineWidth', 1.5);
semilogy(1:iter_gr{1}, err_gr{1},'LineWidth', 1.5)
for i = 2:sIdx
    semilogy(1:iter_jb{i}, err_jb{i}, '--', 'LineWidth', 1.5)
    semilogy(1:iter_gb{i}, err_gb{i}, 'LineWidth', 1.5);
    semilogy(1:iter_jr{i}, err_jr{i}, '.-', 'LineWidth', 1.5)
    semilogy(1:iter_gr{i}, err_gr{i}, 'LineWidth', 1.5);
    leg = [leg ['Block Jacobi (BFS)            - ', num2str(bs(i))], ['Block Gauss-Seidel (BFS) - ', num2str(bs(i))] ['Block Jacobi (RCM)            - ', num2str(bs(i))], ['Block Gauss-Seidel (RCM) - ', num2str(bs(i))]];
end
legend(leg);
title(['Convergence for ', num2str(dim),'x', num2str(dim), ' Matrix (Permuted)']);
xlabel('Iteration Count');
ylabel('||Ax - b||/||b||');
set(gca,'FontSize',fontsize);
