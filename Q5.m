function[] = Q5(ns, alpha)
    err = zeros(length(ns), 1);
    for i = 1:length(ns)
        %%Coarse grid solution
        [Ac,bc] = Diffusion(ns(i), alpha, 2);
        x_c = Ludecomp(Ac, bc, 0.01, ns(i)^2);
        x_c = reshape(x_c,[ns(i), ns(i)]); %reshape for L2 calculation
        %%Fine grid solution
        [Af,bf] = Diffusion(ns(i)*2-1, alpha, 2);
        x_f = Ludecomp(Af, bf, 0.01, (ns(i)*2-1)^2);
        x_f = reshape(x_f,[ns(i)*2-1, ns(i)*2-1]); %reshape for L2 calculation

        temp = x_f(1:2:ns(i)*2-1, 1:2:ns(i)*2-1); %corresponding value of coarse grid in fine grid
        e = norm(temp - x_c) / power(ns(i), 2); %average L2 norm's sum as error
        err(i) = e;
    end

    p = polyfit(ns, err, 2);
    f = polyval(p, ns);
    
    figure();
    txt = ['y = (' num2str(p(1)) ')x^2+ (' num2str(p(2)) ')x+ (' num2str(p(3)) ')'];
    plot(ns, err, '-o', ns, f, '-');
    legend('data','2nd degree fit')
    
    title_str = sprintf('Error Evluation Alpha=%d', alpha);
    title(title_str)
    
    text(2, 2, txt);
    
    xlabel('Coarse grid resolution') %add an x label
    ylabel('average error in norm2') % add a y label
end