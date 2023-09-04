clc, clear;
data = load('G:\Data\dataset\uspst_uni.mat','X');
label = load('G:\Data\dataset\uspst_uni.mat','Y');
data = struct2cell(data);
label = struct2cell(label);
data = cell2mat(data);
label = cell2mat(label);
data = double(data);
data = mapminmax(data,0,1);
data = data';
% label = label';
label = label + 1;
c = 10;
num = 1;
alphat=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y'];
excel = actxserver('Excel.Application');
workbook = excel.Workbooks.Open('G:\Data\RFKM\new\result.xlsx');
worksheet = workbook.Sheets.Item(4);
for r = 1.1 : 0.1 : 2 
    begin = [alphat(1),num2str(num)];
    ends = [alphat(1),num2str(num)];
    ff = [begin,':',ends];
    parameter(1,1) = r;
    range = worksheet.Range(ff);
    range.Value = parameter;
    workbook.Save();
    index = 1;
while 0<1
    if index == 26
        break;
    end
    
    [F,obj_FCM,iter] = FuzzyCmeans(data, c, r);

    [~,max_F] = max(F,[],2);
    
    [Purity, ACC, ARI, NMI] = Evaluation(label, max_F);
    
    result(1,1)=iter;
    result(2,1)=obj_FCM(iter);
    result(3,1)=Purity;
    result(4,1)=ARI;
    result(5,1)=ACC;
    result(6,1)=NMI;
    sss = alphat(index);
    begin = [sss,num2str(num + 1)];
    ends = [sss,num2str(num + 6)];
    fi = [begin,':',ends];
    range = worksheet.Range(fi);
    range.Value = result;
    workbook.Save();
    index = index + 1;
end
    num = num + 7;
    i = i - 1;
end
workbook.Close(false);
excel.Quit();
