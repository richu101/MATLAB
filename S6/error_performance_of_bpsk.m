%aim : Encode using error performance using BPSK
%. Generate a string of message bits. 
%2. Encode using BPSK with energy per bit Eb and represent it using points in 
%a signal-space. 
%3. Simulate transmission of the BPSK modulated signal via an AWGN 
%channel with variance N0/2. 
%4. Detect using an ML decoder and plot the probability of error as a function 
%of SNR per bit Eb/N0. 
clc;
clear all;
close all;
%carrier Signal
t= 0:0.01:0.49;
EC= sin(2*pi*10*t);
%coverting to unit energy signal, using gram schmidt orthogonalization
EC1= (1/sqrt(sum(EC.^2))).*EC;
subplot(3,1,1)
plot(t,EC1)
xlabel('time in sec');
ylabel("Voltage");
title("Carrier Signal");
axis([0 0.5 -0.4 0.4]);
%message Signal
N= 10000;%It is known as the message points
x=randi([0,1],1,N);
x2= (2*x)-1; %NRZ coding
x1=[];%message signal for plotting
t1= 0:0.02:9.98;
for j=1:10
    x1= [x1 x2(j)*(ones(1,50)*5)];
end
subplot(3,1,2);
plot(t1,x1(1:500));
xlabel('Time in seconds');
ylabel("Vlotage");
title("Message Signal");
axis([0 10 -10 10]);
% Modulation
b=[];
for i=1:N
    if(x(i)==0)
        mod1= -EC1;
    else
        mod1= EC1;
    end
    b=[b mod1];
end
subplot(3,1,3);
%t1= 0:0.01:10;
plot(t1,b(1:500));
xlabel('Time in Seconds');
ylabel('Voltage');
title('Modulated Signal');
axis([0 10 -0.4 0.4]);

%adding AWGN to the modulated signal
vara=[];
BER=[];
BERtheor2 =[];
Eb_N02=[];
Eb= sqrt(sum(EC1.^2));
for h=0:0.1:1
    var=h^2;
    vara=[vara var];
    w= b+h.*randn(1,length(b));%length of b and length of w should be same
    %to demodulate the noise modulated signal W,the carrier signal should be
%multipied with W at present W is of order 1x500 and EC1 is of the order
%1x50 
%Hence matrix mutiplication is not possible.So we are going to reshape
%noise modulated signal W to the order 50x10000
w1= reshape(w,50,length(b)/50);
%carrier demodulation is happening below.
g= w1'*EC1';
f= zeros(length(g),1);
for i=1:N
    if g(i)>0
        s(i)=1;
    else
        s(i)=0;
    end
end
%finding practical BER
u= xor(x,s);%x is the retrived message signal
ber= sum(u)/N;
BER= [BER ber];
% finding theoretical BER
BERtheor1=0.5*erfc(sqrt(Eb/2*var));
BERtheor2= [BERtheor2 BERtheor1];

% Calculate of SNR
Eb_N01= (1/(2*var));
Eb_N02= [Eb_N02 Eb_N01];
%scatterplot([g,f]);
end
figure;
%practical Diagram SNR vs BER

semilogy((10)*log10(Eb_N02),BER,'-*g');
xlabel('SNR in db');
ylabel('BER');
title('Practical and Theoretical Diagram SNR vs BER');
hold on;
%theoretical Diagram SNR vs BER

semilogy(10*log10(Eb_N02),BERtheor2,'-*r');
axis([-5 20 0.00001 1]);
a= legend("Theoretical BER","Pratical BER");







