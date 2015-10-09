function result = testRegression( polynomial )
%testRegression calculates the deviation of a polynomial regression
%   polynomial - the form of regression
%   result - the standard deviation of one-dimentional regression

sigma = 1;
r = numel(polynomial) - 1;
X = linspace(-1000,1000,2001);
n = numel(X);
Y = polyval(polynomial(end:-1:1),X) + sigma*randn(1,n);

evalPolynomial = oneDimRegression(X, Y, r);
result = standardDeviation(X, Y, evalPolynomial);

end