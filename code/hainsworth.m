%%find the tempo of a song%%

function [ DF ] = hainsworth( s, fspec, sbints )
	%HAINSWORTH     Produces the Hainsworth onset detection function
	K = [];
	for i=1:size(sbints,1)
	    [minimum k1] = min(abs(fspec-sbints(i,1)));
	    [minimum k2] = min(abs(fspec-sbints(i,2)));
	    K = [K k1:k2];
	end
	K = unique(sort(K));

	sk = s(K,:);        % take out the selected frequencise
	sk = log2(abs(sk));
	d = diff(sk')';     % get dm between two colomns
	d = max(d,0);       % find out the positive elements
	DF = sum(d);        % sum up the positive elements in each colomn

end

