function [x,y] = busqueda_local(f,iter,n,d,a)

    % f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
    minimizador_viejo = [];
    for i = 1:d
        minimizador_viejo = [minimizador_viejo a(i,1)+(a(i,2)-a(i,1))*rand(1)];
    end
    minimo_viejo = f(minimizador_viejo);
    m=0;

    while m<iter
        aleatorios = zeros(n,d);
        for j = 1:n
            for i = 1:d
                aleatorios(j,i) = rand*(a(i,2)-a(i,1))+a(i,1);
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