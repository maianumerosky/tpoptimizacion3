%f = @(x) (x(1)-0.5).^2+(x(2)-0.75).^2;
% f = @levi;
f = @griewank;
x0 = rand(1,2).*[200,200]+[-100,-100];
lb = [-100 -100];
ub = [100 100];


% [x y t n xx yy] = recocido_simulado(f,x0,'A','[-100,100;-100,100]','MaxIter','inf','tlim','30');
[x y t n xx yy] = hibrido(f,60,2,'A','[-100,100;-100,100]','MaxIter','inf','tlim','30');
    
figure
plot(yy,'.')
saveas(gcf, 'GriewankHI12_1', 'fig')

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
saveas(gcf, 'GriewankHI12_2', 'fig')

disp(['x0 aleatorio: ',num2str(x0)]);
disp(['Minimizador: ',mat2str(x)]);
disp(['Fmin: ',num2str(y)]);
disp(['Cantidad de iteraciones: ',num2str(n)]);
disp(['Tiempo: ',num2str(t)])
disp(['Gradiente: ',num2str(gradiente(f,x'))]);