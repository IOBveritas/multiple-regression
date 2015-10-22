function result = multipleRegression(F, Coefs)
%Function performs multi-dimentional polynomial regression.
%   F - presentation of multiple polynomial, each row represent member of polynomial
%   result - the coefficients of the polynomial
%   n - number of variables x1, x2, ... , xn
%   m - number of members of the polynomial

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
        A = fv.^C(1:end, k)';
        C(1:end, k) = 0;
    end
    
    [X, Y] = tryExperiment(F, Coefs, k, fv);
    P = sum(C, 2);
    r = max(P);
    Q = oneDimRegression(X, Y, r);
    
    for i = 0:r
        ind = find(P==i);
        if ~isempty(ind) 
            S(end + 1, ind) = A(ind);
            B(end + 1, 1) = Q(i + 1);
        end
    end
end
       
result = pinv(S)*B;
end

function result = fixVariable(varInd)
    result = unifrnd(-100, 100);
end

function [rX, rY] = tryExperiment(F, C, FixedVarInd, FixedVars)

X = -100:100;
Y = zeros(1, 201);

if FixedVarInd > 0
    C = C.*(FixedVars.^F(1:end, FixedVarInd)');
    F(1:end, FixedVarInd) = 0;
end

for i = 1:numel(X)
    if X(i) ~= 0
        Y(i) = sum(C.*(prod(X(i).^F, 2)'));
    else
        Y(i) = 0;
    end
end

rX = X;
rY = Y;

end