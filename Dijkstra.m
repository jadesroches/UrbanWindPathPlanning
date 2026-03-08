function [guess_path, path, expected_path_cost] = Dijkstra(numnodes, Cost_guess, j, path, expected_path_cost, start, goal)
%% Compute the current minimum-cost path on the urban graph
% This function applies Dijkstra's algorithm to the directed graph defined
% by the current edge-cost estimate. In the paper, it is used at each pass
% to select the minimum-time route from the start node to the goal node.
%
% Inputs:
%   numnodes           - total number of graph nodes
%   Cost_guess         - current directed edge-cost matrix
%   j                  - pass index
%   path               - running storage array for previously computed paths
%   expected_path_cost - running storage array for predicted path costs
%   start              - start node index
%   goal               - goal node index
%
% Outputs:
%   guess_path         - minimum-cost path found for the current pass
%   path               - updated path history
%   expected_path_cost - updated predicted path-cost history

    %% Initialization
    d=inf(1,numnodes); d(start)=0; % label
    marker=ones(1,numnodes); marker(start)=2; % marker U=1, V=2, C=3
    b=NaN(1,numnodes); %back parker (parent)
    P=start; % fringe
    goalreached = 0;  
    
    % main loop
    
    while not(goalreached)
        
        I=P(1); P(1) = []; % Pop P(1)
        marker(I)=3;
        J = find(abs(Cost_guess(I,:))>0); % J = connected verticies
        for m=1:length(J)
            
            g=Cost_guess(I,J(m));
            
            if and(not(marker(J(m))==3),(d(I)+g < d(J(m)))) 
                d(J(m))=d(I)+g; % update label
                b(J(m))=I; marker(J(m))=2; % update parent
                P=[P,J(m)];
            end
            [~,ind]=sort(d(P)); % find ascending sorting order of d(P)
            P=P(ind); % resort P so that P(1) has the smallest d
            
            equal_good = find(d==d(P(1))); % find the equally best options
            
            if length(equal_good)>1 % randomly resorts equally best options
                neworder = randperm(length(equal_good));
                P(1:length(equal_good)) = P(neworder);
            end
        
        end
        
        if P(1)==goal
            goalreached=1;
            expected_path_cost(j)=d(P(1));
        end
    end
    
    b_ = goal;
    guess_path = goal;
    while not(b_==start)
        guess_path = [b(b_);guess_path];
        b_ = b(b_);
    end
    
    path(1:length(guess_path),j) = guess_path;
    
    end