function[res] = Ludecomp(a, b, tol, n)
%%n is the number of element in each colomn in A 
o = 1:n;
s = 1:n;
er = 0;
res = 1:n;
[a, er, o] = Decompose(a, n, tol, o, s, er);
if er ~= -1
    res = Substitute(a, o, n, b);
end

end