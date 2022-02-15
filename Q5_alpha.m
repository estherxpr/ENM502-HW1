function[] = Q5_alpha(n, alphas)
    err = zeros(length(alphas), 1);
    for i = 1:length(alphas)
        %%Coarse grid solution
        [Ac,bc] = Diffusion(n, alphas(i), 2);
        x_c = Ludecomp(Ac, bc, 0.01, n^2);
        x_c = reshape(x_c,[n, n]); %reshape for L2 calculation
        %%Fine grid solution
        [Af,bf] = Diffusion(n*2-1, alphas(i), 2);
        x_f = Ludecomp(Af, bf, 0.01, (n*2-1)^2);
        x_f = reshape(x_f,[n*2-1, n*2-1]); %reshape for L2 calculation

        temp = x_f(1:2:n*2-1, 1:2:n*2-1); %corresponding value of coarse grid in fine grid
        e = norm(temp - x_c) / power(n, 2); %average L2 norm's sum as error
        err(i) = e;
    end
    
    p = polyfit(alphas, err, 2);
    f = polyval(p, alphas);
    
    figure();
    txt = ['y = (' num2str(p(1)) ')x^2+ (' num2str(p(2)) ')x+ (' num2str(p(3)) ')'];
    plot(alphas, err, '-o', alphas, f, '-');
    
    title_str = sprintf('Error Evluation grid res=%d', n);
    title(title_str)
    
    text(2, 2, txt);
    
    xlabel('Alpha value') %add an x label
    ylabel('average error in norm2') % add a y label
end