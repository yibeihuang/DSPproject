%%Realizes the single pitch detection by autoCorrDetection%%
%%output--two numbers: 1. result obtained by autoCorrDetection in time domain; 2. in frequency domain

function f = autoCorrDetection(x,fs)
%divide a signal into several small pieces, since a short part of the signal can be seen as a periodic signal with unchanged magnitude
len = floor(length(x)/25);
%take only a certain piece to be processed
xs = x(len:len*2-1);  %only applied for single note, a period
y = xcorr(xs(1:len/10),xs); %to make the envelope of the autocorrelation be as constant as possible; reduce running time

%figure;plot(y);
Y = fftshift(fft(y(floor(len/2):len)));
axis = 1:length(Y);
%figure;plot(axis,abs(Y));

%---use y immediately---%
[pks, locs] = findpeaks(y,'minpeakheight',y(len)*0.8);
inter = mean(diff(locs));
f(1) = fs/inter; %the period of the signal

%---use the frequency domain---%
[maxvalue, loc] = max(abs(Y));
f(2) = abs(loc-length(Y)/2)/length(Y)*fs;

end