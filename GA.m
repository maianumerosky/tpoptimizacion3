% Incompletoooo
%Falta definir la parte de Select with Replacement!


popsize = 20;
n = 3;
Best = [];
iter = 1;
MaxNumIter: 1000

P = zeros(popsize,n);
for i = 1:popsize
    P(i,:) = rand(1,n);

while iter < MaxNumIter
    for i = 1:popsize
        if f(P(i,:)) < f(Best)
            Best = P(i,:);
        end
    end
    Q = [];
    for i = 1:popsize/2
        Pa = ...
        Pb = ...
        [Ca Cb] = cover2(Pa,Pb);
        Q = [Q mutar(Ca) mutar(Cb)];
    end
    P = Q;
end

    
