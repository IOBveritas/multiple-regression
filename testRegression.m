function result = testRegression( polynomial )
%testRegression calculates the deviation of a polynomial regression
%   polynomial - the form of regression

r = numel(polynomial) - 1;
normalDistribution = makedist('Normal','mu',0,'sigma',1);
X = linspace(-1000,1000,2001);
n = numel(X);
Y = zeros(1,n);

for i = 1:n
    error = normalDistribution.random();
    Y(i) = polyval(polynomial(end:-1:1),X(i)) + error;
end

evalPolynomial = oneDimRegression(X, Y, r);
result = standardDeviation(X, Y, evalPolynomial);

end