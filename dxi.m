function y = dxi(f,x,i)
% agarra x columna, devuelve la derivada parcial i-esima 
    h = 0.0001;
    Id= eye(length(x));
    ei = Id(:,i);
    y = (f(x + h*ei)- f(x))/h;