function[] = Q3(n, dim, alpha)
%solving the solution
[A, b] = Diffusion(n, alpha, dim);

%%tol = 0.01
x = Ludecomp(A, b, 0.01, n^dim);
    
%% Visualize
f = figure();
if dim == 1
    T = x;
    plot(T);
    xlabel('grid index') %add an x label
    ylabel('T') % add a y label
    title_str = sprintf('%d Grid', n);
    title(title_str);
end

if dim == 2
    T = reshape(x, n, n);
    contourf(T);
    colorbar;
    title_str = sprintf('%dx%d Grid', n, n);
    title(title_str);
end
      
filename = sprintf('./results/%d_%d.png', n, dim);
saveas(f, filename);
end