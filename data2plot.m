clear;clc;close all;
arr=strsplit(pwd,'\');
filename=strcat(cell2mat(arr(end)),'.xlsx');
[ref,temp]=xlsread(filename);
I=zeros(size(ref));
for i=1:length(ref)
    s=cell2mat(temp(i,1));
    s(isspace(s)) = [];
    char2asc2=abs(s);%转asc2
    char2asc2(char2asc2==abs('V'))=[];%删除V
    s=char(char2asc2);
    ref(i)=str2double(s);    
    s=cell2mat(temp(i,2));
    s(isspace(s)) = [];
    char2asc2=abs(s);%转asc2
    char2asc2(char2asc2==abs('A'))=[];%删除A
    s=char(char2asc2);
    I(i)=str2double(s);
end
Q=I;
for i=2:length(Q)
    Q(i)=Q(i)+Q(i-1);
end
remQper=flip(Q.*1e2./Q(end));
ref=[ref I Q remQper];
% 间隔点采样100个,已在mat中
for a=100:-1:1
    [D,I] = min(abs(a-remQper));
    simple(a)=ref(I,1);
end
save(strcat(cell2mat(arr(end)),'.mat'), 'ref','simple');clear;

% 数据已保存，以下内容可隐藏
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
remQper=ref(:,4);
figure('NumberTitle', 'off', 'Name', 'Q/V for Once');
plot(ref(:,1),remQper,'b-','LineWidth',1);
hold on;
% 检查采样曲线
% plot(simple,1:100,'m-');
ylim([0 105]);
title('capacity-voltage');
xlabel('Voltage/V');
ylabel('Capacity/%');
set(gca,'XDir','reverse')%对X方向反转
% set(gca,'YDir','reverse')%对Y方向反转
legend('AAA battery×2');
grid on;
hold off;
