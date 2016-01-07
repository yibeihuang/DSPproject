%%find peaks and corresponding locations of a signal%%

function [peaks locs] = freqSeq(x)
	for i=1:4
   		[peaks(i) locs(i)] = max(x);
    	x(locs(i)-10:locs(i)+10) = zeros(21,1);  %eliminate peaks of the notes that has already be recognized
	end

	%[p, l] = findpeaks(x);
	%p = sort(p,'descend');
	%for i=1:4
	%    peaks(i) = p(i);
	%    locs(i)= find(x==p(i));
	%end
end