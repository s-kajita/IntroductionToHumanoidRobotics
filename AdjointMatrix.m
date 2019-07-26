function adjM = AdjointMatrix(M)
% calculate Adjoint (Adjugate) matrix adjM where M^(-1) = det(M)*adjM
% M must be a square matrix.

Nrow = size(M,1);
Ncol = size(M,2);

adjM = zeros(Nrow,Ncol);

if Ncol ~= Nrow
    fprintf('ERROR: Matrix must be square\n');
else
    for n=1:Ncol
        Mn = M;
        Mn(n,:) = [];        % Submatrix of M without row-n
        for k=1:Nrow
            Mnk = Mn;
            Mnk(:,k) = [];   % Submatrix of M without row-n and column-k 
            adjM(k,n) = (-1)^(n+k)*det(Mnk);
        end
    end
end