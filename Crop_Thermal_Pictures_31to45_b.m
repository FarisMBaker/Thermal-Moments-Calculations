clear all;
close all;
clc;

InputOriginalTempraturesPath = 'C:\Faris\Thermal Database\InputThermalOriginal\'
InputTipCoordinatesPath = 'C:\Faris\Thermal Database\InputThermalCoordinates\'
OutputCroppedTempraturesPath ='C:\Faris\Thermal Database\OutputThermalCroppedWidth60\'


FirstPerson = 1;
LastPerson = 20;

PictureNumberStart = 31;
PictureNumberEnd = 45;
xWidth = 60; %%% previously the width was 80, now total width is 120
yHight = 90;

for Person = FirstPerson:LastPerson
    
    display(Person);
    
    SheetNumber = num2str(Person);
    
    for PictureNumber = PictureNumberStart: PictureNumberEnd
                
                InputOriginalTempraturesFile=strcat(InputOriginalTempraturesPath,num2str(Person),'\',num2str(PictureNumber),'.csv');
                PictureTempratures = xlsread(InputOriginalTempraturesFile);
                display(size(PictureTempratures));
                
                %%%
                %%% Input the coordinates of the tip of nose
                %%%
                
                 InputTipCoordinatesFile=strcat(InputTipCoordinatesPath,'ThermalCoordinates90Degree','.xlsx');
                 
                 SheetNo = Person;
                 
                 switch PictureNumber
                     
                        case 31
                                xCell ='B2';
                                yCell ='C2';
                        case 32
                                xCell ='B3';
                                yCell ='C3';
                        case 33
                                xCell ='B4';
                                yCell ='C4';
                        case 34
                                xCell ='B5';
                                yCell ='C5';
                        case 35
                                xCell ='B6';
                                yCell ='C6';
                        case 36
                                xCell ='B7';
                                yCell ='C7';
                        case 37
                                xCell ='B8';
                                yCell ='C8';
                        case 38
                                xCell ='B9';
                                yCell ='C9';
                        case 39
                                xCell ='B10';
                                yCell ='C10';
                        case 40
                                xCell ='B11';
                                yCell ='C11';
                        case 41
                                xCell ='B12';
                                yCell ='C12';
                        case 42
                                xCell ='B13';
                                yCell ='C13';
                        case 43
                                xCell ='B14';
                                yCell ='C14';
                        case 44
                                xCell ='B15';
                                yCell ='C15';
                        case 45
                                xCell ='B16';
                                yCell ='C16';
                    end;
                    
                 display('*******************');   
                 
                 display(PictureNumber);
                 
                 xCoordinate = xlsread( InputTipCoordinatesFile,SheetNo, xCell)
                 yCoordinate = xlsread( InputTipCoordinatesFile,SheetNo, yCell) 
                 
                 display('*******************');
                 
                 xStart = xCoordinate - xWidth
                 xEnd = xCoordinate + xWidth 
                 yStart = yCoordinate - yHight 
                 yEnd = yCoordinate + yHight 
                 
                 %%% y coordinate : represent the rows of the matrix
                 %%% x coordinate : represent the columns of the matrix
                 %%% B = A (row1:row2,col1:col2)
                 
                 CroppedTempratures = PictureTempratures(yStart:yEnd,xStart:xEnd);
                 display(size(CroppedTempratures));
                 
                 OutputFile=strcat(OutputCroppedTempraturesPath,num2str(Person),'\',num2str(PictureNumber),'.csv');
                 delete(OutputFile);
                 OutputFile=strcat(OutputCroppedTempraturesPath,num2str(Person),'\',num2str(PictureNumber),'.csv');
                 xlswrite(OutputFile,CroppedTempratures);
     end;
end;
       

                

%---NameLocation = strcat('A',num2str(PersonNumber),':','A',num2str(PersonNumber));
%---
%--- xlsread returns 
%---            ndata   :   numeric data in array ndata 
%---            text    :   text data in cell array text 
%---            alldata :   unprocessed data in cell array alldata
%---
%---[ndata, text, alldata] = xlsread(InputNamesPerson,NameLocation);
 
 