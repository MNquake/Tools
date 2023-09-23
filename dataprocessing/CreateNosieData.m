clear;clc;
data = load('E:\Data\dataset\ORL32x32.mat','X');
label = load('E:\Data\dataset\ORL32x32.mat','Y');
data = struct2cell(data);
label = struct2cell(label);
data = cell2mat(data);
label = cell2mat(label);
data = double(data);
[r, c] = size(data);
num = fix(r * 0.2);
X = data;
Y = label;
Y = Y';
[m,n]=size(X);
MaxV = max(X(:));
MinV = min(X(:));
for i = 1:num
%     A = -1 + 2*rand(1, 256);
     A = randi([MaxV+fix(0.5*(MaxV-MinV)), MaxV+fix(1.5*(MaxV-MinV))], [1, c]);
%     A = MinV + (MaxV - MinV) * rand([1, c]);
    idx = randi(r+1);

    X_top = X(1:idx-1,:);
    X_bottom = X(idx:end,:);
    X = [X_top; A; X_bottom];
    
    Y_top = Y(1:idx-1,:);
    Y_bottom = Y(idx:end,:);
    Y = [Y_top; 0; Y_bottom];

end
Y = Y';
T = 1;
% for i = 1:num
%     A = randi([30, 255], [1, 256]);
%     data(end+1,:) = A;
%     label(:,end+1) = 0;
% end
% X = data;
% Y = label;
save('ORL32x32_outlier_nosiy.mat', 'X', 'Y');