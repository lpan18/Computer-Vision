function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
%Your implementation here
    % Calculate bins for rho and theta, then initiate H   
    [m, n] = size(Im);
    rhoScale = 0:rhoRes:ceil(sqrt(m^2+n^2));
    thetaScale = 0:thetaRes:2*pi;
    H = zeros(length(rhoScale), length(thetaScale));
    % Voting
    for y = 1:m
        for x = 1:n
            if Im(y,x) > threshold
               for thetaPos = 1:length(thetaScale)
                    theta = thetaScale(thetaPos);
                    rho = x * cos(theta) + y * sin(theta);
                    %  negative rho values are invalid
                    if(rho < 0) 
                        continue;
                    end
                    rhoPos = floor(rho/rhoRes) + 1;
                    H(rhoPos,thetaPos) = H(rhoPos,thetaPos) + 1;
                end
            end
        end
    end
    % figure, imshow(H);
end