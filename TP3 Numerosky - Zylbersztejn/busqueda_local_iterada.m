function [x,y, varargout] = busqueda_local_iterada(f,x0, varargin)

d = length(x0);

A = opcion('A',varargin,[zeros(d,1) ones(d,1)]);
n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);
iter = opcion('n',varargin,10000);
tlim = opcion('tlim',varargin,300);
alpha = opcion('alpha',varargin,0.05);

intermediosx = [];
intermediosy = [];

minimizador_viejo = x0;
minimo_viejo = f(minimizador_viejo);

Ub = A(:,2)'; %Los limites superiores del dominio en fila
Lb = A(:,1)'; %Los limites inferiores del dominio en fila

m = 0;
tinicio = tic; %Para que no se mezcle con los tics anidados
while m < MaxIter && toc(tinicio)<tlim
    [candidato,fcandidato] = busqueda_local(f,minimizador_viejo,'MaxIter',num2str(iter),'n',num2str(n),'A',mat2str(A),'tlim',num2str(tlim),'alpha',num2str(alpha));
    if minimo_viejo > fcandidato
        x = candidato;
        y = fcandidato;
    end
    
    minimizador_viejo = rand(1,d).*(Ub-Lb)+Lb;
    m = m+1;
    intermediosx = [intermediosx x'];
    intermediosy = [intermediosy y];
end

varargout{1} = toc(tinicio);
varargout{2} = m;
varargout{3} = intermediosx;
varargout{4} = intermediosy;