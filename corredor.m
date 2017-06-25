
f = @rosenbruck;
x0 = [0 0 0 0 0 0];

[x y t n yy] = GA(f,100,10);
plot(yy,'.')

disp(['Minimizador: ',mat2str(x)]);
disp(['Fmin: ',num2str(y)]);
disp(['Cantidad de iteraciones: ',num2str(n)]);
disp(['Tiempo: ',num2str(t)])