clc,clear; %清除命令，清空工作区，关闭所有窗口
data = load('E:\Data\dataset\olivetti.mat','X');
label = load('E:\Data\dataset\olivetti.mat','Y');
data = struct2cell(data);
label = struct2cell(label);
data = cell2mat(data);
label = cell2mat(label);
data = double(data);
data = mapminmax(data,0,1);
% data = data';
% label = label+1;
label = label';
k = 10;                        % 类别
metric = @euclidean;
cluster_name = 'ORL32x32';
K = 5;
i = 10;
alphat=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y'];
percent = 0.1;
excel = actxserver('Excel.Application');
workbook = excel.Workbooks.Open('E:\RFKM\result\FuzzyCmeans_result.xlsx');
worksheet = workbook.Sheets.Item(7);
num = 1;
for r = 1.1 : 0.1 : 2
    begin = [alphat(1),num2str(num)];
    ends = [alphat(3),num2str(num)];
    ff = [begin,':',ends];
    parameter(1,1) = r;
    parameter(1,2) = 0;
    parameter(1,3) = 0;
    range = worksheet.Range(ff);
    range.Value = parameter;
    workbook.Save();
    index = 1;
    tic
while 0<1
    if index == 26
        break;
    end
    [prediction,v,iter] = FuzzyCmeans(k, data, r, metric, 100, 0.01);
    [label_idx,~] = find(label == 0);
    for t = label_idx
        label(t) = randi(k, 1);
    end
   
    [Purity, ACC, ARI, NMI] = Evaluation(label, prediction');
    
    result(1,1)=iter;
    result(2,1)=0;
    result(3,1)=Purity;
    result(4,1)=ARI;
    result(5,1)=ACC;
    result(6,1)=NMI;
    sss = alphat(index);
    begin = [sss,num2str(num + 1)];
    ends = [sss,num2str(num+6)];
    fi = [begin,':',ends];
    range = worksheet.Range(fi);
    range.Value = result;
    workbook.Save();
    %xlswrite('G:\Data\RFKM\result.xlsx', result, 'Sheet2', fi);
    index = index + 1;
end
    num = num + 7;
    i = i - 1;
    time = (i * toc) / 3600;
    fprintf('此次迭代用时：%f s, 剩余迭代次数：%d 次，算法剩余时间：%f h\n',toc, i, time);
end
workbook.Close(false);
excel.Quit();