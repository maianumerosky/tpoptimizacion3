function [x,y varargout] = busqueda_local(f,x0,varargin)
%Funcion que busca el minimo haciendo descenso aleatorio con busqueda local iterada.
%Empieza con un punto al azar en la "caja" a que da el usuario,
%se mueve 0.05 alrededor de ese punto (a menos que se pase) y genera n
%puntos al azar en esa nueva caja. Busca el mejor y compara con el
%anterior. Repite MaxIter veces. La funcion f:Rd-->R.

d = length(x0);

A = opcion('A',varargin,[zeros(d,1) ones(d,1)]);
n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);
tlim = opcion('tlim',varargin,300);
alpha = opcion('alpha',varargin,0.05);

intermediosx = [];
intermediosy = [];

minimizador_viejo = x0;
minimo_viejo = f(minimizador_viejo);
m=0;

tinicio = tic; %Comienza a contar tiempo
while m<MaxIter && toc(tinicio)<tlim

%Construyo una cajita alrededor de ese punto

    Anueva = zeros(d,2);
    for j = 1:d
        Anueva(j,1) = max(minimizador_viejo(j)-alpha,A(j,1));
        Anueva(j,2) = min(minimizador_viejo(j)+alpha,A(j,2));
    end

    [minimizador_viejo y] = descenso_aleatorio(f,minimizador_viejo,'A',mat2str(Anueva),'MaxIter','1','n',num2str(n),'tlim',num2str(tlim));

    m = m +1;   
    intermediosx = [intermediosx minimizador_viejo'];
    intermediosy = [intermediosy y];
end

varargout{1} = toc(tinicio);
varargout{2} = m;
varargout{3} = intermediosx;
varargout{4} = intermediosy;
x = minimizador_viejo;