function adjM = AdjointMatrix(M)
% calculate Adjoint (Adjugate) matrix adjM where M^(-1) = det(M)*adjM

Nrow = size(M,1);
Ncol = size(M,2);
adjM = zeros(Nrow,Ncol);

if Ncol ~= Nrow
    fprintf('ERROR: Matrix must be square\n');
else
    for j=1:Ncol
        Mj = M;
        Mj(j,:) = [];        % Submatrix of M without row-j
        for k=1:Nrow
            Mjk = Mj;
            Mjk(:,k) = [];   % Submatrix of M without row-j and column-k 
            adjM(k,j) = (-1)^(j+k)*det(Mjk);
        end
    end
end