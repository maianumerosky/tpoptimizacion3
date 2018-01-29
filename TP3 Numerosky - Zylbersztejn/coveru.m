function [y1,y2] = coveru(x1,x2)
l = length(x1);
p = 1/l;

y1 = x1;
y2 = x2;

for i=1:l
    if p >= rand
        y1(i) = x2(i);
        y2(i) = x1(i);
    end
end
