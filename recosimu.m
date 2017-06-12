function Best = recosimu(f,x)
t = 10000000;
S = x;
Best = S;
n = 1000;
nn = 1000;
a = -100;
b = 100;
m = size(x);

for j = 1:nn
    for i=1:n
        R = rand(m)*(b-a) + a;
        if f(R)<f(S) || rand < exp((f(R)-f(S))/t)
            S = R;
        end
    end
    t = t/2;
    if f(S) < f(Best)
        Best = S;
    end
end

