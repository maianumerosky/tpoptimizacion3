function y = mutar(x)

d= length(x);
p = 1/d;
sigma2 = 1;
min = -inf;
max = inf;
l = length(x);

for i=1:l
    if p>= rand
        n = sqrt(sigma2)*randn;
        while ~(min <= x(i)+n && max >= x(i)+n)
            n = sqrt(sigma2)*randn;
        end
        x(i) = x(i) + n;
    end
end
y = x;    