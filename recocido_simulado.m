function [x y] = recocido_simulado(f,x0,varargin)

t = opcion('Temp',varargin,1000); %temperatura inicial
k = opcion('FracTemp',varargin,1.05); %fraccion de temperatura. Para descenso

A = opcion('Dominio',varargin,[]);
paso = opcion('Paso',varargin,@(t) sqrt(t)); %Parametro para longitud de paso segun la temp
desc = opcion('desc',varargin,@(t) t/k);
n = opcion('CantPasos',varargin,1000);
MaxIter = opcion('MaxIter',varargin,10000);
tTol = opcion('tTol',varargin,10^-10);
tlim = opcion('tlim',varargin,300);

Ub = A(:,2)';
Lb = A(:,1)';

S = x0;
Best = S;
m = size(x);
d = length(x);
m = 0;



tic
while m <MaxIter && t>tTol && toc<tlim
    for i=1:n
        R = paso(t)*randn(m) + S; %Para elegir un numero al azar 
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
        
        if f(R)<f(S) || rand < exp((f(S)-f(R))/t)
            S = R;
        end
    end
    t = desc(t);
    if f(S) < f(Best)
        Best = S;
    end
    m = m +1;
end

x = Best;
y = f(Best);