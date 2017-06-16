function f = rosenbruck(x)
f = 0;
n = length (x);
for i=1:n-1
    f = f + (1-x(i))^2 + 100*(x(i) - x(i+1)^2)^2;
end