function [x,y varargout] = descenso_aleatorio(f,x0,varargin)

d = length(x0);

A = opcion('Dominio',varargin,[zeros(d,1) ones(d,1)]);
n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);
tlim = opcion('tlim',varargin,300);

Ub = A(:,2)'; %Los limites superiores del dominio en fila
Lb = A(:,1)'; %Los limites inferiores del dominio en fila

intermedios = [];

%Funcion que busca el minimo haciendo descenso aleatorio. Toma n puntos al
%azar en la "caja" A que opcionalmente da el usuario, busca el mejor y compara con el
%anterior. Repite iter veces. La funcion f:Rd-->R.

    % f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
 %Empiezo con un punto al azar en el dominio
%% Borrar si se acepta esta modificacion
%     minimizador_viejo = [];
%     for i = 1:d
%         minimizador_viejo = [minimizador_viejo A(i,1)+(A(i,2)-A(i,1))*rand(1)];
%     end

%%
minimizador_viejo = x0;
minimo_viejo = f(minimizador_viejo);
m=0;
%Genero n puntos al azar en A

tic; %Comienzo a correr el tiempo, lo guardo para evitar conflictos debido al anidamiento de tic
while m<MaxIter && toc<tlim
    aleatorios = zeros(n,d);
    for i = 1:n
        aleatorios(i,:) = rand(1,d).*(Ub-Lb)+Lb;
    end
    
    %% Borrar si se acepta esta modificacion
%     for j = 1:n
%         for i = 1:d
%             aleatorios(j,i) = rand*(A(i,2)-A(i,1))+A(i,1);
%         end
%     end
    %%
%Evaluo cada uno de ellos      
    f_aleatorios = zeros(n,1) ;
    for i = 1:n
        f_aleatorios(i) = f(aleatorios(i,:));
    end
    
%Me fijo cual es el mejor y recupero el indice
    [fmin,minimo_indice] = min(f_aleatorios);
    minimo_valor = aleatorios(minimo_indice,:);
    
%Lo comparo con el anterior
    if fmin < minimo_viejo
       minimizador_viejo = minimo_valor;
       minimo_viejo = fmin; 
    end
    m = m + 1; 
    intermedios = [intermedios minimo_viejo];
end

varargout{1} = toc;
varargout{2} = m;
varargout{3} = intermedios;
x = minimo_valor;
y = fmin;