%% 提取xlsx文件中结果最好的项
i = 1;
xlspath = 'G:/Data/RFKM/new/newRFKM.xlsx';
sheetnames = 'yale32';
range = sprintf('%s%d:%s%d', char('A'),1,char('Y'), 1680);
data = readmatrix(xlspath,'Sheet', sheetnames, 'Range', range);
[m,n] = size(data);

excel = actxserver('Excel.Application');
workbook = excel.Workbooks.Open('G:/Data/RFKM/new/best.xlsx');
worksheet = workbook.Sheets.Item(1);

%iter output purity ari acc nmi
MaxPurity = [0, 0 ,0 ,0, 0, 0]; 
MaxARI = [0, 0 ,0 ,0, 0, 0];
MaxACC = [0, 0 ,0 ,0, 0, 0];
MaxNMI = [0, 0 ,0 ,0, 0, 0];

MaxPurity_param = [0, 0 ,0]; 
MaxARI_param = [0, 0 ,0];
MaxACC_param = [0, 0 ,0];
MaxNMI_param = [0, 0 ,0];
while 1>0
    if i > m
        break;
    end
    param = data(i,1:3);
    result = data(i+1:i+6,1:25);
    
    for t = 1 : 1 : 25
        Purity = result(3,t);
        ARI = result(4,t);
        ACC = result(5,t);
        NMI = result(6,t);
        if Purity > MaxPurity(3)
            MaxPurity = [result(1,t), result(2,t), result(3,t), result(4,t), result(5,t), result(6,t)];
            MaxPurity_param = param; 
        end

        if ARI > MaxARI(4)
            MaxARI = [result(1,t), result(2,t), result(3,t), result(4,t), result(5,t), result(6,t)];
            MaxARI_param = param;
        end

        if ACC > MaxACC(5)
            MaxACC = [result(1,t), result(2,t), result(3,t), result(4,t), result(5,t), result(6,t)];
            MaxACC_param = param;
        end

        if NMI > MaxNMI(6)
            MaxNMI = [result(1,t), result(2,t), result(3,t), result(4,t), result(5,t), result(6,t)];
            MaxNMI_param = param;
        end
    end
    i = i + 7;
end

begin = ['A',num2str(1)];
ends = ['F',num2str(1)];
ff = [begin,':',ends];
contents(1,1) = 1;
contents(1,2) = 2;
contents(1,3) = 3;
contents(1,4) = 4;
contents(1,5) = 5;
contents(1,6) = 6;
range = worksheet.Range(ff);
range.Value = contents;
workbook.Save();

%%--------------------------------

begin = ['A',num2str(2)];
ends = ['A',num2str(2)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = "MaxPurity";
workbook.Save();

begin = ['A',num2str(3)];
ends = ['C',num2str(3)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxPurity_param;
workbook.Save();

begin = ['A',num2str(4)];
ends = ['F',num2str(4)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxPurity;
workbook.Save();

%%----------------------------------

begin = ['A',num2str(5)];
ends = ['A',num2str(5)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = 'MaxARI';
workbook.Save();

begin = ['A',num2str(6)];
ends = ['C',num2str(6)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxARI_param;
workbook.Save();

begin = ['A',num2str(7)];
ends = ['F',num2str(7)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxARI;
workbook.Save();

%%--------------------------------

begin = ['A',num2str(8)];
ends = ['A',num2str(8)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = 'MaxACC';
workbook.Save();

begin = ['A',num2str(9)];
ends = ['C',num2str(9)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxACC_param;
workbook.Save();

begin = ['A',num2str(10)];
ends = ['F',num2str(10)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxACC;
workbook.Save();

%%-------------------------------

begin = ['A',num2str(11)];
ends = ['A',num2str(11)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = 'MaxNMI';
workbook.Save();

begin = ['A',num2str(12)];
ends = ['C',num2str(12)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxNMI_param;
workbook.Save();

begin = ['A',num2str(13)];
ends = ['F',num2str(13)];
ff = [begin,':',ends];
range = worksheet.Range(ff);
range.Value = MaxNMI;
workbook.Save();

workbook.Close(false);
excel.Quit();
