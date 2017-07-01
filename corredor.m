%f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
f = @rosenbruck;
% x0 = [0,0];
% lb = [0 0];
% ub = [2 2];

[x y t n xx yy] = GA(f,30,4,'A','[0,2;0,2;0,2;0,2]','MaxIter','inf','tlim','30','crossover','coverl');

figure
plot(yy,'.')
saveas(gcf, 'RosenGA1_1', 'fig')

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
saveas(gcf, 'RosenGA1_2', 'fig')

disp(['Minimizador: ',mat2str(x)]);
disp(['Fmin: ',num2str(y)]);
disp(['Cantidad de iteraciones: ',num2str(n)]);
disp(['Tiempo: ',num2str(t)])