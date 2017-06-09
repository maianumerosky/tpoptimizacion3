function [x,y] = descenso_aleatorio(f,iter,n)

% f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
minimizador_viejo = rand(1,2);
minimo_viejo = f(minimizador_viejo);
m=0;

while m<iter
    aleatorios = rand(n,2);
    f_aleatorios = [];
    for i = 1:100
        f_aleatorios(i) = f([aleatorios(i,1),aleatorios(i,2)]);
    end
    [fmin,minimo_indice] = min(f_aleatorios);
    minimo_valor = [aleatorios(minimo_indice,1),aleatorios(minimo_indice,2)];
    if fmin < minimo_viejo
       minimizador_viejo = minimo_valor;
       minimo_viejo = fmin; 
    end
    m = m +1; 
end
x= minimo_valor
y = fmin