function result = oneDimRegression( X, Y, r )
%Function performs the one-dimentional polynomial regression.
%   X, Y - arrays of coordinates
%   r - the power of the evaluative polynomial
%   result - the coefficients of the polynomial
%   Y(x) = A0 + A1 * x + ... + Ar * x ^ r - the form of the polynomial

%   first initialization
n = numel(X);

%   input validation
if n ~= numel(Y) || r < 0 || n == 0
    disp('incorrect input data');
    return;
end

%   first elements
Q = 1 / sqrt(n);
W = sum(Y) * Q;

if r > 0
    mean = sum(X) / n;
    Q(2,1:2) = [-mean / sqrt(sum((X - mean).^2)), 1 / sqrt(sum((X - mean).^2))];
    W(2) = sum( Y.*polyval(Q(2,end:-1:1),X) );
    
    %   building matrix Q, vector w
    for j = 3:(r+1)
        %   alpha
        alpha = sum( X.*(polyval(Q(j-1,end:-1:1),X).^2) );
        
        %   beta
        beta = sum( X.*(polyval(Q(j-1,end:-1:1),X).*polyval(Q(j-2,end:-1:1),X)) );

        %   lambda
        lambda = sqrt(sum( ((X - alpha).*polyval(Q(j-1,end:-1:1),X) - beta * polyval(Q(j-2,end:-1:1),X)).^2 ));

        %   next polynomial of Q
        Q(j,1:j) = ([0 Q(j-1,:)] - alpha * [Q(j-1,:) 0] - beta * [Q(j-2,:) 0]) / lambda;
        
        %   calculation Wj
        W(j) = sum( Y.*polyval(Q(j,end:-1:1),X) );
    end
end

result = W*Q;

end