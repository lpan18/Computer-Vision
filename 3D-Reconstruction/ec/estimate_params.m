function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
    % Compute the camera center c by using SVD
    P = P * sign(det(P(1:3, 1:3)));
    [U, S, V] = svd(P);
    c = V(:,end); %4*1
    c = c(1:3)./c(4);
    % Compute the intrinsic K and rotation R, RQ decompositions of square matrices
    A = P(:,1:3);
    pdiag = [0 0 1; 0 1 0; 1 0 0];
    Ar = pdiag * A;
    [Qr, Rr] = qr(Ar');
    R = pdiag * Qr';
    K = pdiag * Rr' * pdiag;
    % Enforce positive diagonal of K 
    D = diag(sign(diag(K)));
    K = K*D;
    R = D*R;
    % Compute the translation
    t = -R*c;
end