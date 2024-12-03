%Prva rešitev (scatteredInterpolant):
opts = detectImportOptions('vozlisca_temperature_dn2.txt');
opts.DataLines = [5, 89411];
tabela = readtable('vozlisca_temperature_dn2.txt', opts);

x1 = table2array(tabela(:, 1));
y1 = table2array(tabela(:, 2));
T1 = table2array(tabela(:, 3));

tic
F1 = scatteredInterpolant(x1, y1, T1, 'linear', 'none');
T_vrednost1 = F1(0.403, 0.503);
time1 = toc;

display(T_vrednost1);
display(time1);

%Druga rešitev (griddedInterpolant):
tabela2 = readmatrix('vozlisca_temperature_dn2.txt','NumHeaderLines',4);
x2 = tabela2(:,1);
y2 = tabela2(:,2);
T2 = tabela2(:,3);

x21 = 371;
y21 = 241;
x_grid0 = unique(x2);
y_grid0 = unique(y2);
[x_grid,y_grid] = ndgrid(x_grid0,y_grid0);
T_grid = reshape(T2,x21,y21);

tic
F2 = griddedInterpolant(x_grid,y_grid,T_grid,'linear','none');
T_vrednost2 = F2(0.403,0.503);
time2 = toc;

display(T_vrednost2);
display(time2);

%Tretja rešitev (interpolacija):
celica = readmatrix("celice_dn2.txt",'NumHeaderLines',2);
tic;
cell_found = false;
for i = 1:size(celica, 1)
    vozlisca = celica(i, :);

    x31 = x2(vozlisca(1)); y31 = y2(vozlisca(1)); T31 = T2(vozlisca(1));
    x32 = x2(vozlisca(2)); y32 = y2(vozlisca(2)); T32 = T2(vozlisca(2));
    x33 = x2(vozlisca(3)); y33 = y2(vozlisca(3)); T311 = T2(vozlisca(3));
    x34 = x2(vozlisca(4)); y34 = y2(vozlisca(4)); T321 = T2(vozlisca(4));

    x_min = min([x31, x32, x33, x34]);
    x_max = max([x31, x32, x33, x34]);
    y_min = min([y31, y32, y33, y34]);
    y_max = max([y31, y32, y33, y34]);

    if (0.403 >= x_min && 0.403 <= x_max && 0.503 >= y_min && 0.503 <= y_max)
    cell_found = true;
    break;
    end
end

K1 = ((x_max - x_target) / (x_max - x_min)) * T11 + ((x_target - x_min) / (x_max - x_min)) * T21;
K2 = ((x_max - x_target) / (x_max - x_min)) * T12 + ((x_target - x_min) / (x_max - x_min)) * T22;
T_vrednost3 = ((y_max - y_target) / (y_max - y_min)) * K1 +((y_target - y_min) / (y_max - y_min)) * K2;

time3 = toc;
display(T_vrednost3);
display(time3);

%Max temperatura
[max_temp, idx] = max(T);
x_max = x2(idx);
y_max = y2(idx);
display(max_temp);
display(x_max);
display(y_max);

