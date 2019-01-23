clear;clc;close all;
arr=strsplit(pwd,'\');
filename=strcat(cell2mat(arr(end)),'.xlsx');clear arr;
[ref,temp]=xlsread(filename);
for i=1:length(ref)
    s=cell2mat(temp(i,1));
    s(isspace(s)) = [];
    char2asc2=abs(s);%转asc2
    char2asc2(char2asc2==abs('V'))=[];%删除5
    s=char(char2asc2);
    ref(i)=str2double(s);
end
I=zeros(size(ref));
for i=1:length(ref)
    s=cell2mat(temp(i,2));
    s(isspace(s)) = [];
    char2asc2=abs(s);%转asc2
    char2asc2(char2asc2==abs('A'))=[];%删除5
    s=char(char2asc2);
    I(i)=str2double(s);
end
ref=[ref I];
save ( 'volt.mat', 'ref');clear;
load volt;
figure('NumberTitle', 'off', 'Name', 'energytrend');
plot(ref(:,1));
xlim([0 1e5]);
hold on;
title('电压变化趋势');
xlabel('时间/s');
ylabel('电压/V');
legend('两节7号电池');
grid on;
hold off;