function crossVel = crosswind(Area, Vel, dP, phi, gridsize)
%% Compute the crosswind correction used during edge traversal
% This function computes the lateral wind contribution used in the main
% simulation when the vehicle traverses edges influenced by crossflow.
% The correction is based on a fixed geometric/flow coefficient extracted
% from the urban graph and scaled by the instantaneous driving signal.
%
% Inputs:
%   Area     - edge-area matrix from the urban graph
%   Vel      - directed edge-wind matrix
%   dP       - instantaneous temporal driving signal
%   phi      - instantaneous directional angle
%   gridsize - two-element vector [nRows, nCols]
%
% Output:
%   crossVel - scalar crosswind correction applied during traversal

    % Cache the fixed geometric coefficient on the first call because it
    % depends only on the graph structure and nominal flow field.
    persistent K_fixed twoM
    if isempty(K_fixed)
        N = gridsize(2);       % number of columns
        M = gridsize(1) - 2;   % number of interior rows

        % Extract the fixed block associated with the first interior row.
        A_blk = Area(N+1:2*N, 1:N);
        V_blk = Vel(N+1:2*N, 1:N);

        % The diagonal dot product defines the constant crossflow scaling.
        K_fixed = dot(diag(A_blk), diag(V_blk));

        % Precompute the normalization factor used at every time step.
        twoM = 2 * M;
    end

    % Compute the crosswind contribution for the current signal state.
    masslost = K_fixed * dP * (1 - cos(phi));
    crossVel = masslost / twoM;

    % Reverse the sign when the directional angle changes orientation.
    if phi < 0
        crossVel = -crossVel;
    end
end