function [x,y] = busqueda_local_iterada(f,iter1,iter2,n,d,a)

%Empiezo con un punto al azar en a

    x = [];
    for i = 1:d
        x = [x a(i,1)+(a(i,2)-a(i,1))*rand];
    end
    y = f(x);    

k = 0;

while k < iter2
    [candidato,fcandidato] = busqueda_local(f,iter1,n,d,a);
    if y > fcandidato
        x = candidato;
        y = fcandidato;
    end
    k = k+1;
end