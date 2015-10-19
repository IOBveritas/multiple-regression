function result = multipleRegression(F)
%Function performs multi-dimentional polynomial regression.
%   F - presentation of multiple polynomial, each row represent member of polynomial
%   result - the coefficients of the polynomial
%   n - number of variables x1, x2, ... , xn
%   m - number of memers of the polynomial

[m, n] = size(F);

% S B - linear equations ai1 + ai2 + .. + aik = b
S = zeros(0, m);
B = [];

for k = 0:n
    C = F;
    A = ones([1 m]);
    fv = 0;
    if k > 0
        fv = fixVariable(k);
        A = A.*(fv.^C(1:end, k)');
        C(1:end, k) = 0;
    end
    
    [X, Y] = tryExperiment(C, [k fv]);
    P = sum(C, 2);
    r = max(P);
    Q = oneDimRegression(X, Y, r);
    
    for i = 1:r
        ind = find(P==i);
        if ~isempty(ind) 
            S(end + 1, ind) = A(ind);
            B(end + 1, 1) = Q(i);
        end
    end
end
       
result = A\B;
end