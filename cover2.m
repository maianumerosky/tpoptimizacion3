function [y1, y2] = cover2(x1,x2)
l = length(x1);
a = randi([1,l],1,2);

m = min(a);
M = max(a);

y1 = x1;
y2 = x2;

if ~(m==M)
    for i=m:M-1
        y1(i) = x2(i);
        y2(i) = x1(i);
    end
end
