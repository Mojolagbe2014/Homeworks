% function to get one-sided FFT of given data
% inputs: signal -row vector of data
%         sampleInterval -time between samples
% returns: T -one-sided FFT values for given data
%          f -frequency axis scale

function [T, f] = ftrans(signal, sampleInterval)

sigLen = length(signal);
signal = [signal, zeros(1,10000)];  %zero-padding (comment to speed-up, but lose frequency refinement)
NFFT = 2^nextpow2(length(signal)); %Next power of 2 from length of signal
Y = fft(signal,NFFT)/sigLen; %compute fft
T = 2*Y(1:NFFT/2+1); %make it one-sided
f = (1/sampleInterval)/2*linspace(0,1,NFFT/2+1); %determine frequency axis

