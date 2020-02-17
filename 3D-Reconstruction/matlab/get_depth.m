function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
c1 = -(K1 * R1) \ (K1 * t1);
c2 = -(K2 * R2) \ (K2 * t2);
b=norm(c1-c2);
f=K1(1,1);

[n,m] = size(dispM);
depthM = zeros(n,m);
for i=1:n
    for j=1:m
        if(dispM(i,j) == 0)
            depthM(i,j) = 0;
        else
            depthM(i,j) = b * f / dispM(i,j);
        end
    end
end

end