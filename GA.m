function [x y varargout] = GA(f,popsize,d,varargin)

A = opcion('A',varargin,[zeros(d,1) ones(d,1)]);
MaxIter = opcion('MaxIter',varargin,10000);
tlim = opcion('tlim',varargin,300);
ParamSelec = opcion('ParamSelec',varargin,4);
crossover = opcion('crossver',varargin,@cover2);
% mutar = opcion('mutar',varargin,@mutar);

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

tic
while m < MaxIter && toc<tlim
    for i = 1:popsize
        if isempty(Best) || f(P(i,:)) < f(Best)
            Best = P(i,:);
        end
    end
    
    Q = [];
    for i = 1:popsize/2
        Pa = seleccion(f,P,ParamSelec);
        Pb = seleccion(f,P,ParamSelec);
        [Ca Cb] = crossover(Pa,Pb);
        Ca = mutar(Ca);
        Cb = mutar(Cb);
        
        %Que Ca y Cb se mantengan dentro del dominio
        if ~isempty(A) %Si no esta vacio el Dominio dado por el usuario
            for coord = 1:d
                if Ca(coord) > Ub(coord)
                    Ca(coord) = Ub(coord);
                elseif Ca(coord) < Lb(coord)
                    Ca(coord) = Lb(coord);
                end
                if Cb(coord) > Ub(coord)
                    Cb(coord) = Ub(coord);
                elseif Cb(coord) < Lb(coord)
                    Cb(coord) = Lb(coord);
                end
            end
        end
        
        Q = [Q; Ca; Cb];
    end
    P = Q;
    m = m + 1;
    
    intermediosx = [intermediosx Best'];
    intermediosy = [intermediosy f(Best)];
end

x = Best;
y = f(Best);

varargout{1} = toc;
varargout{2} = m;
varargout{3} = intermediosx;
varargout{4} = intermediosy;