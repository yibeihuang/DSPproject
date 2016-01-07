clc;
clear;

%%make a record for a song%%

%%output: one vector, three figures
%%vector: pitch names of each note in the song
%%figure 1: tempo and wave of the song
%%figure 2: frequecies at each time
%%figure 3: STFT of the song

%set parameters for STFT
WINDOW = 1024;
NOVERLAP = 512;
NFFT = 1024;

%read audio file
list = dir('data/sin_songs/*.wav');
for l = 1:length(list)
	list(l).name

	%[x fs] = audioread('little star.wav');
	
	[x fs] = audioread(['data/sin_songs/' list(l).name]);
	[freq record tspec DF] = musicRecord(x,fs,WINDOW,NOVERLAP,NFFT);

	%output
	path = '../output/';
	mkdir(path);

	figure;
	subplot(2,1,1);plot(tspec(2:end),DF);
	subplot(2,1,2);plot(x);
	pic_name1 = [path 'TempoandWave' '_' num2str(l) '.jpg'];
	exportfig(gcf,pic_name1,'format','jpeg','color','rgb');

	figure;
	plot(tspec,freq);
	pic_name2 = [path 'FreqinTime' '_' num2str(l) '.jpg'];
	exportfig(gcf,pic_name2,'format','jpeg','color','rgb');

	figure;
	spectrogram(x,WINDOW,NOVERLAP,NFFT,fs,'yaxis');
	pic_name3 = [path 'STFT' '_' num2str(l) '.jpg'];
	exportfig(gcf,pic_name3,'format','jpeg','color','rgb');

	record;
end