%filter a 16 QAM signal using a pair of raised cosine matched filters
%plot a eye diagram
clc;
clear all;
%close all;
M= 16;
k= log2(M);
n = 20000;
sps=4; %samples per signal
%specifying filter parameters
span= 10;
rolloff= 0.8;
%create a raised cosine trasmit filter
txfilter= comm.RaisedCosineTransmitFilter("RolloffFactor",rolloff,"FilterSpanInSymbols",span,...
    "OutputSamplesPerSymbol",sps);
%create the raised cosin recieved filtter
rxfilter= comm.RaisedCosineReceiveFilter("RolloffFactor",rolloff,"FilterSpanInSymbols",span,...
    "InputSamplesPerSymbol",sps);

%plot the impulse response of the tx filter
fvtool(txfilter,'impulse');
%random variable
message= randi([0 1],n,1);
%qam modulation
modSignal= qammod(message,M,'InputType','bit');
%filter the modulated signal
filteredsignal= txfilter(modSignal);
%plot the eye diagram
eyediagram(filteredsignal(1:1000),2*sps);















