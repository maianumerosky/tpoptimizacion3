function Best = recocido_simulado(f,x,varargin)

t = opcion('Temp',varargin,1000); %temperatura inicial
k = opcion('FracTemp',varargin,1.05); %fraccion de temperatura. Para descenso

Ub = opcion('Ub',varargin,[]); %upperbound
Lb = opcion('Lb',varargin,[]); %lowerbound
paso = opcion('Paso',varargin,@(t) sqrt(t)); %Parametro para longitud de paso segun la temp
desc = opcion('desc',varargin,@(t) t/k);
n = opcion('CantPasos',varargin,1000);
MaxIter = opcion('MaxIter',varargin,10000000);
tTol = opcion('tTol',varargin,10^-10);
tlim = opcion('tlim',varargin,300);

S = x;
Best = S;
m = size(x);
d = length(x);
iter = 0;



tic
while iter <MaxIter && t>tTol && toc<tlim
    for i=1:n
        R = paso(t)*randn(m) + S; %el ...*2-1 lo que hace es buscar numeros entre -1 y 1
        %Arreglo el R por si salio de la caja
        for coord = 1:d
            if ~(isempty(Ub) && isempty(Lb)) %Si no estan vacios los bordes
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
    iter = iter +1;
end

