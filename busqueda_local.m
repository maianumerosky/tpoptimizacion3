function [x,y varargout] = busqueda_local(f,x0,varargin)
%Funcion que busca el minimo haciendo descenso aleatorio con busqueda local iterada.
%Empieza con un punto al azar en la "caja" a que da el usuario,
%se mueve 0.05 alrededor de ese punto (a menos que se pase) y genera n
%puntos al azar en esa nueva caja. Busca el mejor y compara con el
%anterior. Repite MaxIter veces. La funcion f:Rd-->R.

d = length(x0);

A = opcion('Dominio',varargin,[zeros(d,1) ones(d,1)]);
n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);
tlim = opcion('tlim',varargin,300);

intermedios = [];

minimizador_viejo = x0;
minimo_viejo = f(minimizador_viejo);
m=0;

tinicio = tic; %Comienza a contar tiempo
while m<MaxIter && toc(tinicio)<tlim

%Construyo una cajita alrededor de ese punto

    Anueva = zeros(d,2);
    for j = 1:d
        Anueva(j,1) = max(minimizador_viejo(j)-0.1,A(j,1));
        Anueva(j,2) = min(minimizador_viejo(j)+0.1,A(j,2));
    end

    [minimizador_viejo y] = descenso_aleatorio(f,minimizador_viejo,'Dominio',mat2str(Anueva),'MaxIter','1','n',num2str(n),'tlim',num2str(tlim));

       %% Borrar si hay acuerdo
%        
%     Ub = Anueva(:,2)'; %Limite superior en fila
%     Lb = Anueva(:,1)'; %Limite inferior en fila
% %Genero n puntos aleatorios en esa cajita
%     %% Borrar si se acepta la modificacion
% %     aleatorios = zeros(n,d);
% %     for j = 1:n
% %         for i = 1:d
% %             aleatorios(j,i) = rand*(Anueva(i,2)-Anueva(i,1))+Anueva(i,1);
% %         end
% %     end
%     %%
%     aleatorios = zeros(n,d);
%     for i = 1:n
%         aleatorios(i,:) = rand(1,d).*(Ub-Lb)+Lb;
%     end
% 
% %Los evaluo
% 
%     f_aleatorios = zeros(n,1) ;
%     for i = 1:n
%         f_aleatorios(i) = f(aleatorios(i,:));
%     end
% 
% %Busco minimo y minimizador
% 
%     [fmin,minimo_indice] = min(f_aleatorios);
%     minimo_valor = [];
%     for k = 1:d
%         minimo_valor = [minimo_valor aleatorios(minimo_indice,k)];
%     end
% 
% %Comparo y veo con cual me quedo
% 
%     if fmin < minimo_viejo
%        minimizador_viejo = minimo_valor;
%        minimo_viejo = fmin; 
%     end

    m = m +1;   
    intermedios = [intermedios y];
end

varargout{1} = toc(tinicio);
varargout{2} = m;
varargout{3} = intermedios;
x = minimizador_viejo;