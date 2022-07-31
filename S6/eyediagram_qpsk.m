clc;
clear all;
close all;
% generation of eye diagram for filtered qpsk signal\
% generate random symbols
data=randi([0 3],1000,1);
%qpsk modulation
modSig=pskmod(data,4,pi/4);
% using raised cosine filter
sps=4;% samples per second
txfilter=comm.RaisedCosineTransmitFilter("OutputSamplesPerSymbol",sps)



filterdSignal=txfilter(modSig);
% display eye diagram
eyediagram(filterdSignal,2*sps);