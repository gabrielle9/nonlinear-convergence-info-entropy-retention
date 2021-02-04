% from https://stackoverflow.com/questions/28284671/generating-all-combinations-with-repetition-using-matlab
% if values is an integer, combs is an integer
% if values is a vector of values in your set, combs returns a [(n+k-1)!/(k!(n-1)!),k] matrix of
% combinations with replacement

function combs = nmultichoosek(values, k)
%// Return number of multisubsets or actual multisubsets.
if numel(values)==1 
    n = values;
    combs = nchoosek(n+k-1,k);
else
    n = numel(values);
    combs = bsxfun(@minus, nchoosek(1:n+k-1,k), 0:k-1);
    combs = reshape(values(combs),[],k);
end