close all;clear;clc;
Dirs = dir('*.mat');

simples=[];
for i = 1:length(Dirs)
    load([Dirs(i).name]);
    simples=[simples;simple];
end
[m,n]=size(simples);
averArr=sum(simples,1)/m;

figure('NumberTitle', 'off', 'Name', 'Q/V');
plot(averArr,1:100,'b-','LineWidth',1);
hold on;
ylim([0 105]);
title('capacity-voltage');
xlabel('Voltage/V');
ylabel('Capacity/%');
set(gca,'XDir','reverse')%��X����ת
% set(gca,'YDir','reverse')%��Y����ת
legend('AAA battery��2');
grid on;
hold off;

