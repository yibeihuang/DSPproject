%%training part: generate the "pitch_info" in "pitch_info.mat"%%

list = dir('data/singletone/*.wav');

for i = 1:length(list)
	list(i).name
	[x fs] = audioread(['piano-C5' list(i).name]);
	y = abs(fft(x));
	y = y(1:floor(length(y)/2)); %take only half of y since it is symmetric
	%zero = zeros(100,1);
	y(1:100) = zeros(100,1); %denoise, eliminate noises from the beginninf of the signal
	%find peaks and corresponding locations
	[peaks locs] = freqSeq(y);
	pitch_info(:,1,i) = peaks';
	pitch_info(:,2,i) = locs';

end


%[x fs] = audioread('piano-C5.wav');
% i = 13;
% y = abs(fft(x));
% y = y(1:floor(length(y)/2)); %take half of y since it is symmetric
% zero = zeros(100,1);
% y(1:100) = zero; %denoise, eliminate noises from the beginninf of the signal
% %find peaks and corresponding locations
% [peaks locs] = freqSeq(y);
% pitch_info(:,1,i) = peaks';
% pitch_info(:,2,i) = locs';
