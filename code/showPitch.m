%%find pitches of a single note or chord%%
%%output:
%%1. pitch: pitch names of the detection result
%%2. freq_detect: the detected frequencies
%%3. freq_correct: the corrected frequencies based on freq_detect
%%4. num: number of pitches detected

%[x fs] = audioread('piano-C4.wav');
[x, fs] = audioread('data/chord/13.wav');
[pitch, freq_detect, freq_correct, num] = hps(x,fs)