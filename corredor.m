
f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
x0 = rand(2,1);

[x y t n yy] = descenso_aleatorio(f,100,x0);
plot(yy,'.')

disp(['Minimizador: ',mat2str(x)]);
disp(['Fmin: ',num2str(y)]);
disp(['Cantidad de iteraciones: ',num2str(n)]);
disp(['Tiempo: ',num2str(t)])