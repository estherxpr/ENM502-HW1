function[res] = Substitute(a, o, n, b)
    for i = 2:n
        sum = b(o(i));
        for j = 1:i-1
            sum = sum - a(o(i), j) * b(o(j));
        end
        b(o(i)) = sum;
    end
    res(n) = b(o(n)) / a(o(n), n);
    for i = n-1:-1:1
        sum = 0;
        for j = i+1:n
            sum = sum + a(o(i),j)*res(j);
        end
        res(i)=(b(o(i)) - sum) / a(o(i), i);
    end
end
