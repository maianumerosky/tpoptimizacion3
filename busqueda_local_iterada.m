function [x,y] = busqueda_local_iterada(f,x0, varargin)

d = length(x0);

A = opcion('Dominio',varargin,[zeros(d,1) ones(d,1)]);
n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);
iter = opcion('n',varargin,10000);
tlim = opcion('tlim',varargin,300);


%Empiezo con un punto al azar en a

%% Borrar si se acepta la modificacion
%     x = [];
%     for i = 1:d
%         x = [x A(i,1)+(A(i,2)-A(i,1))*rand];
%     end

minimizador_viejo = x0;
minimo_viejo = f(minimizador_viejo);
%y = f(x0);    

Ub = A(:,2)'; %Los limites superiores del dominio en fila
Lb = A(:,1)'; %Los limites inferiores del dominio en fila

m = 0;
tinicio = tic; %Para que no se mezcle con los tics anidados
while m < MaxIter && toc(tinicio)<tlim
    [candidato,fcandidato] = busqueda_local(f,minimizador_viejo,'MaxIter',num2str(iter),'n',num2str(n),'Dominio',mat2str(A),'tlim','inf');
    if minimo_viejo > fcandidato
        x = candidato;
        y = fcandidato;
    end
    
    minimizador_viejo = rand(1,d).*(Ub-Lb)+Lb;
    m = m+1;
    
end