clear;clc;close all;
arr=strsplit(pwd,'\');
filename=strcat(cell2mat(arr(end)),'.xlsx');
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
Q=I;
for i=2:length(Q)
    Q(i)=Q(i)+Q(i-1);
end
ref=[ref I Q];
save(strcat(cell2mat(arr(end)),'.mat'), 'ref');clear;

arr=strsplit(pwd,'\');
load(strcat(cell2mat(arr(end)),'.mat'));
figure('NumberTitle', 'off', 'Name', 'energytrend');
plot(ref(:,1),'b-','LineWidth',1);%单位1s
xlim([0 1e5]);
hold on;
title('电压变化趋势');
xlabel('时间/s');
ylabel('电压/V');
legend('7号电池×2');
grid on;
hold off;

Q=ref(:,3);
% consQper=Q.*1e2./Q(end);
remQper=flip(Q.*1e2./Q(end));
ref=[ref remQper];
figure('NumberTitle', 'off', 'Name', 'Q/V');
plot(ref(:,1),remQper,'b-','LineWidth',1);
hold on;
title('剩余电量-电压关系');
xlabel('电压/V');
ylabel('剩余电量/%');
set(gca,'XDir','reverse')%对X方向反转
% set(gca,'YDir','reverse')%对Y方向反转
legend('7号电池×2');
grid on;
hold off;

% 多次实验由于电压存在偏移用系数解决
% 求和*系数