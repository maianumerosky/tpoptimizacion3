function Best = seleccion(f,P,t)

l = size(P,1);
Best = P(randi(l),:);
for i = 2:t
    Next = P(randi(l),:);
    if f(Next) < f(Best)
        Best = Next;
    end
end