function [x y varargout] = hibrido(f,popsize,d,varargin)

A = opcion('A',varargin,[zeros(d,1) ones(d,1)]);
MaxIter = opcion('MaxIter',varargin,10000);
tlim = opcion('tlim',varargin,300);
IterBusqueda = opcion('IterBusqueda',varargin,10);

Best = [];
Ub = A(:,2)';
Lb = A(:,1)';
m = 0;

intermediosx = [];
intermediosy = [];

%Genero una poblacion al azar 
P = zeros(popsize,d);
for i = 1:popsize
    P(i,:) = rand(1,d).*(Ub-Lb)+Lb;
end

tinicio = tic;
while m < MaxIter && toc(tinicio)<tlim
    for i = 1:popsize
        P(i,:) = busqueda_local(f,P(i,:),'MaxIter',num2str(IterBusqueda),'tlim','inf','A',mat2str(A));
        if isempty(Best) || f(P(i,:)) < f(Best)
            Best = P(i,:);
        end
    end
      
    m = m + 1;
    intermediosx = [intermediosx Best'];
    intermediosy = [intermediosy f(Best)];
end

x = Best;
y = f(Best);

varargout{1} = toc(tinicio);
varargout{2} = m;
varargout{3} = intermediosx;
varargout{4} = intermediosy;