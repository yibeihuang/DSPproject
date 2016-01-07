%%using HPS algorithm to find out pitches for both single note and chord%%

function [pitch freq_detect freq_correct num] = hps(x,fs)
    %make use of our previously trained pitch info
    load pitch_info;

    delength = 300; %length of headmost samples to be set as zero
    threshold = 70; %set a threthold to avoid the influence of noise caused by sidelobe

    Y0 = abs(fft(x));
    len = floor(length(x)/2);
    axis = 1:len;
    Y0 = Y0(1:len);
    zero = zeros(delength,1); 
    Y0(1:delength) = zero; %denoise
    %figure;
    %plot(axis,Y0);

    Y1 = Y0;
    num = 0;
    while (max(Y1)>threshold) 
        %figure;
        %plot(axis,Y1);

        Y = Y1;
        num = num+1;
        for i=2:5
            subY = downsample(Y1,i);
            subY = [subY; zeros(len-length(subY),1)];
            Y = Y+subY;
        end
        Y(1:delength) = zero; %denoise again
        [v1 loc1] = max(Y);
        freq_detect(num) = loc1/length(x)*fs;
        [v loc] = min(abs(pitch_freq-freq_detect(num)));
        freq_correct(num) = pitch_freq(loc);
        pitch(num) = pitch_name(loc);

        %difference value of the results compared with previously trained infos
        error_loc = pitch_info(1,2,loc)-loc1; 
        error_value = pitch_info(1,1,loc)/v1;

        remove_sample = zeros(len,1);
        for i=1:4
            remove_sample(pitch_info(i,2,loc)-error_loc*i-10:pitch_info(i,2,loc)-error_loc*i+10) = pitch_info(i,1,loc)/error_value;
        end
        Y1 = Y1-remove_sample;
    end
end