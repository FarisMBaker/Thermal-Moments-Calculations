clear all;
close all;
clc;

InputPathName = 'C:\Faris\Thermal Database\InputThermalCropped\'
OutputPathName ='C:\Faris\Thermal Database\OutputThermalCroppedMoment\'

FirstPerson = 1;
LastPerson = 20;
StartPicture = 31;
LastPicture =45;
OutputFile=strcat(OutputPathName,'Moments31to45','.csv');
display(OutputFile);
    
%%% Output Headings
    
RowHeading = {'Moments','m00','m01','m10','m11','m12','m21','m22','m30','m03','m04','m40'};
ColHeading = {'Pictures';31;32;33;34;35;36;37;38;39;40;41;42;43;44;45};
StartRowHeading = 'A1';
StartColHeading = 'A2';
    
for Person = FirstPerson:LastPerson
    
    display(Person);
    
    %%% Start displaying the moments from row 3 in the excel sheet
    
    ExcelSheetName = strcat('P',num2str(Person));
    xlswrite(OutputFile,RowHeading, ExcelSheetName,StartRowHeading);
    xlswrite(OutputFile,ColHeading, ExcelSheetName,StartColHeading);
    
    Row = 3;  
    
    for Picture = StartPicture :LastPicture
        
        display(Picture);      
        InputFile=strcat(InputPathName,num2str(Person),'\',num2str(Picture),'.csv');
        display(InputFile);
        PictureTempratures = xlsread(InputFile);
        
        f = PictureTempratures;
        [rows cols] = size(f);
        M = rows;
        N = cols;
        display(rows);
        display(cols);


        m00 = 0;
        m01 = 0;
        m10 = 0;
        m11 = 0;
        m12 = 0;
        m21 = 0;
        m22 = 0;
        m30 = 0;
        m03 = 0;
        m31 = 0;
        m13 = 0;
        m04 = 0;
        m40 = 0;

        Moments_Storage =[];
 
        for x = 1 : M;
            for y = 1 : N;
                m00 = m00 + (x .^ 0) * (y .^ 0 ) * f(x,y);
                m01 = m01 + (x .^ 0) * (y .^ 1 ) * f(x,y);
                m10 = m10 + (x .^ 1) * (y .^ 0 ) * f(x,y);
            end;
        end;
 
        xmean = m10 / m00 ;
        ymean = m01 / m00 ;
 
        %%%display(xmean);
        %%%display(ymean);
 
        for x = 1 : M;
            for y = 1: N;  
                m11 = m11 + (x - xmean).^1 * (y - ymean).^1 * f(x,y);
                m12 = m12 + (x - xmean).^1 * (y - ymean).^2 * f(x,y);
                m21 = m21 + (x - xmean).^2 * (y - ymean).^1 * f(x,y);
                m22 = m22 + (x - xmean).^2 * (y - ymean).^2 * f(x,y);
                m30 = m30 + (x - xmean).^3 * (y - ymean).^0 * f(x,y);
                m03 = m03 + (x - xmean).^0 * (y - ymean).^3 * f(x,y);   
                m04 = m04 + (x - xmean).^0 * (y - ymean).^4 * f(x,y);
                m40 = m40 + (x - xmean).^4 * (y - ymean).^0 * f(x,y);
            end;
        end;
 
        %%%display(m00);
        %%%display(m01);
        %%%display(m10);
        %%%display(m11);
        %%%display(m12);
        %%%display(m21);
        %%%display(m22);
        %%%display(m30);
        %%%display(m03);
        %%%display(m04);
        %%%display(m40);

        Moments_Storage =[Moments_Storage m00];
        Moments_Storage =[Moments_Storage m01];
        Moments_Storage =[Moments_Storage m10];
        Moments_Storage =[Moments_Storage m11];
        Moments_Storage =[Moments_Storage m12];
        Moments_Storage =[Moments_Storage m21];
        Moments_Storage =[Moments_Storage m22];
        Moments_Storage =[Moments_Storage m30];
        Moments_Storage =[Moments_Storage m03];
        Moments_Storage =[Moments_Storage m04];
        Moments_Storage =[Moments_Storage m40];
        
        %%%display(size(Moments_Storage));
        %%%display(Moments_Storage);
        
        
        ExcelRange =strcat('B',num2str(Row));
        xlswrite(OutputFile,Moments_Storage,ExcelSheetName,ExcelRange);
        Row = Row + 1; %%% advance to the next row to output the moments of the next picture
                             
     end;
end;
       

                



 