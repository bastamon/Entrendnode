clear;clc;close all;
arr=strsplit(pwd,'\');
filename=strcat(cell2mat(arr(end)),'.xlsx');
[ref,temp]=xlsread(filename);
I=zeros(size(ref));
for i=1:length(ref)
    s=cell2mat(temp(i,1));
    s(isspace(s)) = [];
    char2asc2=abs(s);%תasc2
    char2asc2(char2asc2==abs('V'))=[];%ɾ��V
    s=char(char2asc2);
    ref(i)=str2double(s);    
    s=cell2mat(temp(i,2));
    s(isspace(s)) = [];
    char2asc2=abs(s);%תasc2
    char2asc2(char2asc2==abs('A'))=[];%ɾ��A
    s=char(char2asc2);
    I(i)=str2double(s);
end
Q=I;
for i=2:length(Q)
    Q(i)=Q(i)+Q(i-1);
end
remQper=flip(Q.*1e2./Q(end));
ref=[ref I Q remQper];
% ��������100��,����mat��
for a=100:-1:1
    [D,I] = min(abs(a-remQper));
    simple(a)=ref(I,1);
end
save(strcat(cell2mat(arr(end)),'.mat'), 'ref','simple');clear;

% �����ѱ��棬�������ݿ�����
arr=strsplit(pwd,'\');
load(strcat(cell2mat(arr(end)),'.mat'));
figure('NumberTitle', 'off', 'Name', 'energytrend');
plot(ref(:,1),'b-','LineWidth',1);%��λ1s
xlim([0 1e5]);
hold on;
title('��ѹ�仯����');
xlabel('ʱ��/s');
ylabel('��ѹ/V');
legend('7�ŵ�ء�2');
grid on;
hold off;

Q=ref(:,3);
% consQper=Q.*1e2./Q(end);
remQper=ref(:,4);
figure('NumberTitle', 'off', 'Name', 'Q/V for Once');
plot(ref(:,1),remQper,'b-','LineWidth',1);
hold on;
% ����������
% plot(simple,1:100,'m-');
ylim([0 105]);
title('capacity-voltage');
xlabel('Voltage/V');
ylabel('Capacity/%');
set(gca,'XDir','reverse')%��X����ת
% set(gca,'YDir','reverse')%��Y����ת
legend('AAA battery��2');
grid on;
hold off;
