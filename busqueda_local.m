function [x,y] = busqueda_local(f,iter,n,d,a)
%Funcion que busca el minimo haciendo descenso aleatorio con busqueda local iterada.
%Empieza con un punto al azar en la "caja" a que da el usuario,
%se mueve 0.5 alrededor de ese punto (a menos que se pase) y genera n
%puntos al azar en esa nueva caja. Busca el mejor y compara con el
%anterior. Repite iter veces. La funcion f:Rd-->R.


 %Empiezo con un punto al azar en a

    minimizador_viejo = [];
    for i = 1:d
        minimizador_viejo = [minimizador_viejo a(i,1)+(a(i,2)-a(i,1))*rand(1)];
    end
    minimo_viejo = f(minimizador_viejo);
    m=0;

    while m<iter
        a-nueva = zeros(d,2);
        for j = 1:d
            a-nueva(j,1) = minimizador_viejo(j)-0.5;
            a-nueva(j,2) = minimizador_viejo(j)+0.5;
        end
        aleatorios = zeros(n,d);
        for j = 1:n
            for i = 1:d
                aleatorios(j,i) = rand*(a-nueva(i,2)-a-nueva(i,1))+a-nueva(i,1);
            end
        end
        f_aleatorios = zeros(n,1) ;
        for i = 1:n
            for j = 1:d
                f_aleatorios(i) = f(aleatorios(i,:));
            end
        end
        [fmin,minimo_indice] = min(f_aleatorios);
        minimo_valor = [];
        for k = 1:d
            minimo_valor = [minimo_valor aleatorios(minimo_indice,k)];
        end
        if fmin < minimo_viejo
           minimizador_viejo = minimo_valor;
           minimo_viejo = fmin; 
        end
        m = m +1; 
    end
    x= minimo_valor
    y = fmin
    
end