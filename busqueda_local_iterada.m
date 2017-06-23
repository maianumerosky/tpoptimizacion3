function [x,y] = busqueda_local_iterada(f,d,A, varargin)

n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);
iter = opcion('n',varargin,10000);


%Empiezo con un punto al azar en a

    x = [];
    for i = 1:d
        x = [x A(i,1)+(A(i,2)-A(i,1))*rand];
    end
    y = f(x);    

k = 0;

while k < MaxIter
    [candidato,fcandidato] = busqueda_local(f,iter,n,d,A);
    if y > fcandidato
        x = candidato;
        y = fcandidato;
    end
    k = k+1;
end