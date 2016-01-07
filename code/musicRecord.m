function [freq record tspec DF] = musicRecord(x,fs,WINDOW,NOVERLAP,NFFT)
[s fspec tspec p] = spectrogram(x,WINDOW,NOVERLAP,NFFT,fs);
sbints = [0,fspec(end)];
DF = hainsworth(s,fspec,sbints);

%subplot(2,1,1);plot(tspec(2:end),DF);
%subplot(2,1,2);plot(x);

[peaks locsDF] = findpeaks(DF,'minpeakheight',800);
locs = [0 locsDF*512];
for i=1:length(locs)
    sample_u = x(locs(i)+1:locs(i)+5000);
    sample = sample_u;
    for j=1:4
        sample = [sample;sample_u];  %extend the time playing a note, so that hps can have 4 freqs
    end
    [pitch freq_detect freq_correct num] = hps(sample,fs);
    f(i) = freq_correct(1);
    record(i) = pitch(1);
end
locsDF = [0 locsDF length(DF)+1];
for i=1:length(locsDF)-1
    freq(locsDF(i)+1:locsDF(i+1)) = f(i);
end

%figure;
%plot(tspec,freq);
end