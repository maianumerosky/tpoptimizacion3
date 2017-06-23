function Best = GA(f,popsize,MaxNumIter,d)


t = 4;
Best = [];
iter = 1;

P = zeros(popsize,d);
for i = 1:popsize
    P(i,:) = rand(1,d);
end
while iter < MaxNumIter
    for i = 1:popsize
        if isempty(Best) || f(P(i,:)) < f(Best)
            Best = P(i,:);
        end
    end
    Q = [];
    for i = 1:popsize/2
        Pa = seleccion(f,P,t);
        Pb = seleccion(f,P,t);
        [Ca Cb] = cover2(Pa,Pb);
        Q = [Q; mutar(Ca); mutar(Cb)];
    end
    P = Q;
    iter = iter + 1;
end

    
