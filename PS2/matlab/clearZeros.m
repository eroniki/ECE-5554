function [counts, values] = clearZeros(counts, values)
	values(counts==0) = [];
    counts(counts==0) = [];
end

