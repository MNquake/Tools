clc,clear; %清除命令，清空工作区，关闭所有窗口
data = load('E:\Data\dataset\ORL32x32.mat','X');
label = load('E:\Data\dataset\ORL32x32.mat','Y');
data = struct2cell(data);
label = struct2cell(label);
data = cell2mat(data);
label = cell2mat(label);
data = double(data);
data = mapminmax(data,0,1);
data = data';
% label = label+1;
label = label';
k = 40;                        % 类别
cluster_name = 'uspst_uni';
num = 1;
r = 1.1;
K = 5;
i = 25;
alphat=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y'];
percent = 0.1;
excel = actxserver('Excel.Application');
workbook = excel.Workbooks.Open('E:\RFKM\result\Kmeans_result.xlsx');
worksheet = workbook.Sheets.Item(1);
index = 1;
while 0<1
    tic
    if index == 26
        break;
    end
    [cluster, centr,iterations] = Kmeans(k,data);

    [label_idx,~] = find(label == 0);
    for t = label_idx
        label(t) = randi(k, 1);
    end
   
    [Purity, ACC, ARI, NMI] = Evaluation(label, cluster');
    
    result(1,1)=iterations;
    result(2,1)=0;
    result(3,1)=Purity;
    result(4,1)=ARI;
    result(5,1)=ACC;
    result(6,1)=NMI;
    sss = alphat(index);
    begin = [sss,num2str(num)];
    ends = [sss,num2str(num+5)];
    fi = [begin,':',ends];
    range = worksheet.Range(fi);
    range.Value = result;
    workbook.Save();
    %xlswrite('G:\Data\RFKM\result.xlsx', result, 'Sheet2', fi);
    index = index + 1;
    i = i - 1;
    time = (i * toc) / 3600;
    fprintf('此次迭代用时：%f s, 剩余迭代次数：%d 次，算法剩余时间：%f h\n',toc, i, time);
end
workbook.Close(false);
excel.Quit();