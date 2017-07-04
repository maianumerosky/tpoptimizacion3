%f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
f = @levi;
x0 = rand(1,2).*[20,20]+[-10,-10];
lb = [-10 -10];
ub = [-10 10];


[x y t n xx yy] = busqueda_local_iterada(f,x0,'A','[-10,10;-10,10]','MaxIter','inf','tlim','30');
    
figure
plot(yy,'.')
saveas(gcf, 'LeviBLI2_1', 'fig')

figure
hold on
e_x = linspace(lb(1),ub(1),500);
e_y = linspace(lb(2),ub(2),500);
e_z = zeros(length(e_y),length(e_x));
for i = 1:length(e_x)
    for j = 1:length(e_y)
        e_z(i, j) = f([e_x(i), e_y(j)]);
    end
end
contour(e_x,e_y,e_z')
plot3(xx(1,:),xx(2,:),yy,'.')
colorbar
saveas(gcf, 'LeviBLI2_2', 'fig')

disp(['Minimizador: ',mat2str(x)]);
disp(['Fmin: ',num2str(y)]);
disp(['Cantidad de iteraciones: ',num2str(n)]);
disp(['Tiempo: ',num2str(t)])