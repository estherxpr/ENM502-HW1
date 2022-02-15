function[A, b] = Diffusion(n, alpha, dim)
%% dim: The dimension of the diffusion problem: dim = 1, 2
%% n: number of elements in one dimension

%%1d case
%%discretization: dT = h = 1/(n-1)
%%b = [-alpha, -alpha, ....], n elements in total
%%Approxiamation: f''(x_i) = (f(x_i+1)-2f(x_i)+f(x_i-1))/h^2

h = 1/(n-1);
h2inv = 1/(h*h);

A = diag(ones(1,n^dim));
b = zeros(1, n^dim);


%%1D case
if dim == 1
    for i = 2:n^dim-1
        A(i,i) = -2*h2inv;
        A(i,i-1) = h2inv;
        A(i,i+1) = h2inv;
        b(i) = -alpha;
    end
    
    b = b.';
end

if dim == 2
    for j = 1:n-2
        for i = j*n+2:(j+1)*n-1
            A(i,i) =-4*h2inv;
            A(i,i-1) = h2inv;
            A(i,i+1) = h2inv;
            A(i,i-n) = h2inv;
            A(i,i+n) = h2inv;
            b(i) = -alpha;
        end
    end
    
    b = b.';
end

