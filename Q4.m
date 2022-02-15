function[] = Q4(range, steps, dim)
% n: a range like 200:50:800;
% steps: how many steps the method runs for each n
t_intrinsic = length(range); 
t_method = length(range);
alpha = 2;
tol = 0.01;
    
    
for i = 1:length(range)
    n = range(i);
    [A, b] = Diffusion(n, alpha, dim);
        
    temp = 0;
    for j = 1:steps 
        tic;
        A\b;
        temp = temp + toc;
    end
    t_intrinsic(i) = temp / steps; %time for intrinsic method

    temp = 0;
    for j = 1:steps
        tic;
        Ludecomp(A, b, tol, n^dim);
        temp = temp + toc;
    end
    t_method(i) = temp / steps; %time for our method

end

n = log10(range.^dim);
t_intrinsic = -log10(t_intrinsic);
t_method = -log10(t_method);
sampleNum = length(range);
centerPos = floor(sampleNum / 2);

figure(1)
p1 = polyfit(n, t_intrinsic, 1);
f1 = polyval(p1, n);
txt1 = ['y = (' num2str(p1(1)) ')x+ (' num2str(p1(2)) ')'];
plot(n, t_intrinsic, '-o', n, f1, '-');
xlabel('log10( Matrix Size n )')
ylabel('log10( Time in second )') 
title('LU intrinsic method')
legend('data','linear fit')
text(n( centerPos ), f1( centerPos ) - 0.08, txt1);

figure(2)
p2 = polyfit(n, t_method, 1);
f2 = polyval(p2, n);
txt2 = ['y = (' num2str(p2(1)) ')x+ (' num2str(p2(2)) ')'];
plot(n, t_method, '-o', n, f2, '-');
xlabel('log10( Matrix Size n )')
ylabel('log10( Time in second )')
title('LU manual method')
legend('data','linear fit')
text(n( centerPos ), f2( centerPos ) - 0.08, txt2);
end