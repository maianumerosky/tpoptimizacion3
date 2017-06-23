function [x,y] = busqueda_local(f,d,A, varargin)
%Funcion que busca el minimo haciendo descenso aleatorio con busqueda local iterada.
%Empieza con un punto al azar en la "caja" a que da el usuario,
%se mueve 0.5 alrededor de ese punto (a menos que se pase) y genera n
%puntos al azar en esa nueva caja. Busca el mejor y compara con el
%anterior. Repite MaxIter veces. La funcion f:Rd-->R.

n = opcion('n',varargin,100);
MaxIter = opcion('MaxIter',varargin,10000);

%Empiezo con un punto al azar en a

    minimizador_viejo = [];
    for i = 1:d
        minimizador_viejo = [minimizador_viejo A(i,1)+(A(i,2)-A(i,1))*rand];
    end
    minimo_viejo = f(minimizador_viejo);
    m=0;
    
    while m<MaxIter
        
%Construyo una cajita alrededor de ese punto

        Anueva = zeros(d,2);
        for j = 1:d
            Anueva(j,1) = max(minimizador_viejo(j)-0.1,A(j,1));
            Anueva(j,2) = min(minimizador_viejo(j)+0.1,A(j,2));
        end
        
%Genero n puntos aleatorios en esa cajita
        
        aleatorios = zeros(n,d);
        for j = 1:n
            for i = 1:d
                aleatorios(j,i) = rand*(Anueva(i,2)-Anueva(i,1))+Anueva(i,1);
            end
        end
        
%Los evaluo
        
        f_aleatorios = zeros(n,1) ;
        for i = 1:n
            for j = 1:d
                f_aleatorios(i) = f(aleatorios(i,:));
            end
        end
        
%Busco minimo y minimizador
        
        [fmin,minimo_indice] = min(f_aleatorios);
        minimo_valor = [];
        for k = 1:d
            minimo_valor = [minimo_valor aleatorios(minimo_indice,k)];
        end
   
%Comparo y veo con cual me quedo
       
        if fmin < minimo_viejo
           minimizador_viejo = minimo_valor;
           minimo_viejo = fmin; 
        end
        m = m +1; 
    end
    x= minimo_valor;
    y = fmin;
    
end