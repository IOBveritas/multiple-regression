function result = standardDeviation( X, Y, polynomial )
%Function calculates the standard deviation of one-dimentional polynomial
%   regression.
%   X, Y - arrays of coordinates
%   polynomial - the coefficients of the polynomial
%   result - the standard deviation of one-dimentional polynomial regression

n = numel(X);

%   input validation
if n ~= numel(Y) || n == 0
    disp('incorrect input data');
    return;
end

result = sqrt(sum((Y - polyval(polynomial(end:-1:1),X)).^2) / n);

end