function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m
    % Compute the optical center c1 and c2 of each camera
    c1 = -(K1 * R1)\(K1 * t1);
    c2 = -(K2 * R2)\(K2 * t2);
    % Compute the new rotation matrix
    r1 = (c1 - c2)/sqrt(sum((c1-c2).*(c1-c2)));
    r2 = cross(R1(:,3),r1);
    r3 = cross(r2, r1);
    Rnew = [r1, r2, r3]';
    R1n = Rnew;
    R2n = Rnew;
    % Compute the new intrinsic parameter
    Knew = K2;
    K1n = Knew;
    K2n = Knew;
    % Compute the new translation
    t1n = -Rnew * c1;
    t2n = -Rnew * c2;
    % Compute the rectification matrix
    M1 = (Knew * Rnew)/(K1 * R1);
    M2 = (Knew * Rnew)/(K2 * R2);
end