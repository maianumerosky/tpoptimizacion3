function [x,y] = descensoaleatorio(f,iter,n,d,a)
%Funcion que busca el minimo haciendo descenso aleatorio. Toma n puntos al
%azar en la "caja" a que da el usuario, busca el mejor y compara con el
%anterior. Repite iter veces. La funcion f:Rd-->R.

    % f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
 %Empiezo con un punto al azar en a
    minimizador_viejo = [];
    for i = 1:d
        minimizador_viejo = [minimizador_viejo a(i,1)+(a(i,2)-a(i,1))*rand(1)];
    end
    minimo_viejo = f(minimizador_viejo);
    m=0;
%Genero n puntos al azar en a
    while m<iter
        aleatorios = zeros(n,d);
        for j = 1:n
            for i = 1:d
                aleatorios(j,i) = rand*(a(i,2)-a(i,1))+a(i,1);
            end
        end
%Evaluo cada uno de ellos      
        f_aleatorios = zeros(n,1) ;
        for i = 1:n
            for j = 1:d
                f_aleatorios(i) = f(aleatorios(i,:));
            end
        end
%Me fijo cual es el mejor y recupero el indice
        [fmin,minimo_indice] = min(f_aleatorios);
        minimo_valor = [];
        for k = 1:d
            minimo_valor = [minimo_valor aleatorios(minimo_indice,k)];
        end
%Lo comparo con el anterior
        if fmin < minimo_viejo
           minimizador_viejo = minimo_valor;
           minimo_viejo = fmin; 
        end
        m = m +1; 
    end
    x= minimo_valor
    y = fmin
    
end