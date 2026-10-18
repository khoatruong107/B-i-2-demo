clear; clc; close all;

% Khai báo các biến ký hiệu
syms t y x

% Nhập giá trị đầu vào từ bàn phím
v0 = input('Nhập vận tốc ban đầu v0 (m/s): ');
a  = input('Nhập hệ số a: ');

%% ----- CÂU A: Phương trình chuyển động x(t), y(t) -----
y_t = int(v0, t, 0, t);              % y(t) = v0 * t
x_t = int(a * y_t, t, 0, t);         % x(t) = (1/2) * a * v0 * t^2

disp('====================================================');
disp('a) Phương trình chuyển động của khí cầu:');
fprintf('   x(t) = %s\n', char(x_t));
fprintf('   y(t) = %s\n', char(y_t));

%% ----- CÂU B: Phương trình quỹ đạo -----
% Bước 1: Biểu diễn t theo y từ phương trình y_t = y => t = y / v0
t_sol = solve(y_t == y, t);

% Bước 2: Thay t vào x(t) để tìm x theo y => x = (a / (2*v0)) * y^2
x_y = subs(x_t, t, t_sol);

% Bước 3: Tìm y theo x từ phương trình x = x(y)
y_x = solve(x == x_y, y);            % Kết quả ra 2 nghiệm (âm/dương)

disp('====================================================');
disp('b) Phương trình quỹ đạo của khí cầu:');
fprintf('   x(y) = %s\n', char(x_y));
fprintf('   hay y(x) = %s\n', char(y_x(2))); % Lấy nghiệm dương (y >= 0)

%% ----- CÂU C: Vẽ quỹ đạo chuyển động -----
t1 = input('Nhập thời điểm t1 (s) [Mặc định 0]: ');
if isempty(t1), t1 = 0; end

t2 = input('Nhập thời điểm t2 (s) [Mặc định 5]: ');
if isempty(t2), t2 = 5; end

% Chuyển biểu thức ký hiệu (sym) sang function handle để vẽ đồ thị
x_func = matlabFunction(x_t);
y_func = matlabFunction(y_t);

figure('Name', 'Quỹ đạo chuyển động của khí cầu');
% Vẽ đường cong tham số [x(t), y(t)] trong khoảng thời gian [t1, t2]
fplot(x_func, y_func, [t1, t2], 'LineWidth', 2, 'Color', 'b');

grid on;
title(sprintf('QUỸ ĐẠO CỦA VẬT TỪ t = %.1fs ĐẾN t = %.1fs', t1, t2));
xlabel('Tọa độ x (m)');
ylabel('Tọa độ y (m)');