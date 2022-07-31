clc;
clear all;
close all;
t= 0:0.005:10;
dc_offset=2;
x= sin(t)+dc_offset;
%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(t,x);
hold on;
title('message signal DC Offset');
xlabel('Time');
ylabel('Amplitude in volts');
grid on;
%%%%%%%%%%%%%%%%%%%%%

%stem(t,x);
title('message signal DC Offset');
xlabel('Time');
ylabel('Amplitude in volts');
grid on;
%%%%%%%%%%%%%%%%%%%%%
L= input('Enter the no of Quntaization Levels');
Smin= round(min(x));
Smax= round(max(x));
quant_level= linspace(Smin,Smax,L);
codebook= linspace(0,Smax,L+1);
[index,quarts]= quantiz(x,quant_level,codebook);
%%%%%%%%%%%%%%%%%%%%%


plot(t,quarts);
title('Quantized signal');
xlabel('Time');
ylabel('Amplitude in volts');
grid on;
%%%%%%%%%%%%%%%%%%%%

for i=1:length(index)
    bincode_sig{i}=dec2bin(round(index(i)),7);
end
disp('binary encoded signal')
disp(bincode_sig);
noise= quarts-x
r= snr(index,noise)
n=[3 4 5 6 7]
Le= 2.^n
re=[];
for i=1:length(Le)
    Quant_level = linspace(Smin,Smax,Le(i))
    codebook= linspace(0,Smax,Le(i)+1)
    [index,quants]= quantiz(x,Quant_level,codebook)
    noise= quants-x;
    
    re= [re snr(index,noise)];
end
%figure;
plot(Le,re)





