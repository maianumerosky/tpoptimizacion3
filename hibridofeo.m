function [x,y, varargout] = hibridofeo(f,x0, varargin)

d = length(x0);

A = opcion('Dominio',varargin,[zeros(d,1) ones(d,1)]);
n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);
iter = opcion('n',varargin,10000);
tlim = opcion('tlim',varargin,300);


minimizador_viejo = x0;
minimo_viejo = f(minimizador_viejo);

Ub = A(:,2)'; %Los limites superiores del dominio en fila
Lb = A(:,1)'; %Los limites inferiores del dominio en fila

intermedios = [];

m = 0;
tinicio = tic; %Para que no se mezcle con los tics anidados

while m < MaxIter && toc(tinicio)<tlim
    dom_local = zeros(d,2);
    for j = 1:d
        dom_local(j,1) = max(minimizador_viejo(j)-0.1,A(j,1));
        dom_local(j,2) = min(minimizador_viejo(j)+0.1,A(j,2));
    end
    
    [candidato,fcandidato] = GA(f,n,d,'Dominio',mat2str(dom_local),'tlim',num2str(tlim));
    if minimo_viejo > fcandidato
        x = candidato;
        y = fcandidato;
    end
    
    minimizador_viejo = rand(1,d).*(Ub-Lb)+Lb;
    m = m+1;
    intermedios = [intermedios y];
    
end

varargout{1} = toc;
varargout{2} = m;
varargout{3} = intermedios;