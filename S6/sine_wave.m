clc;
clear all;
close all;

x= 1000;
t= 0:0.00001:0.001;
y= 1+sin(2*pi*x*t);
subplot(2,1,1);
z= linspace(1,10,100);
stem(t,y);
xlabel('time');
ylabel('sin(2*pi*f*t)');
title('Sine graph discrete');
%subplot(2,1,2);
hold on;
legend("a");
if r is the number of bits per sample the no of quantization level L = 2^r
    output SQNR
       (SNR)0 in dB= 1.8+6R
                   = 1.8+6x7
                   (SNR)0 in dB= 43.8dB