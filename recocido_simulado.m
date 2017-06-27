function [x y varargout] = recocido_simulado(f,x0,varargin)

temp = opcion('temp',varargin,1000); %temperatura inicial
k = opcion('k',varargin,1.05); %fraccion de temperatura. Para descenso
A = opcion('A',varargin,[]);
paso = opcion('paso',varargin,@(t) sqrt(t)); %Parametro para longitud de paso segun la temp
desc = opcion('desc',varargin,@(t) t/k);
n = opcion('n',varargin,1000);
MaxIter = opcion('MaxIter',varargin,10000);
tempTol = opcion('tempTol',varargin,10^-10);
tlim = opcion('tlim',varargin,300);

if ~isempty(A)
    Ub = A(:,2)';
    Lb = A(:,1)';
end

S = x0;
Best = S;
d = size(x0);
d = length(x0);
m = 0;

intermedios = [];

tic
while m <MaxIter && temp>tempTol && toc<tlim
    for i=1:n
        R = paso(temp)*randn(d) + S; %Para elegir un numero al azar 
        %Arreglo el R por si salio de la caja
        if ~isempty(A) %Si no esta vacio el Dominio dado por el usuario
            for coord = 1:d
                if R(coord) > Ub(coord)
                    R(coord) = Ub(coord);
                elseif R(coord) < Lb(coord)
                    R(coord) = Lb(coord);
                end
            end
        end
        
        if f(R)<f(S) || rand < exp((f(S)-f(R))/temp)
            S = R;
        end
    end
    temp = desc(temp);
    if f(S) < f(Best)
        Best = S;
    end
    m = m +1;
    intermedios = [intermedios f(Best)];
end

x = Best;
y = f(Best);

varargout{1} = toc;
varargout{2} = m;
varargout{3} = intermedios;