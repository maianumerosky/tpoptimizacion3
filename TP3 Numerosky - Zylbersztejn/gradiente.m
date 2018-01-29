function y = gradiente(f,x)
% devuelve el gradiente como fila y toma como input x columna
    n = length(x);
    y = [];
    for i = 1:n
        y = [y, dxi(f,x,i)];
    end
    