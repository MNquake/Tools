function [F,obj_FCM,iter] = FuzzyCmeans(data, c, r)

    % data: d*n
    % c: number of cluster
    % r: membership matrix coefficient

    [d, n] = size(data);

    F = rand(n, c);              %随机模糊矩阵
    row_sum= sum(F, 2);
    F = F./(row_sum*ones(1, c));   %约束条件：每一行累加为1

%     randIdx = randperm(n,c);
%     center = data(:,randIdx);
    G = F.^r;
    center = (G'*data')./(sum(G',2)*ones(1,size(data',2)));
    center = center';

    iter = 1;

%     dist = distfcm(data', center');
    obj_FCM(iter) = 0;

    while 1 > 0
        
        %% update F
        dist = distfcm(data', center');
        for i = 1 : 1 : n
            for j = 1 : 1 : c
                d = 0;
                for k = 1 : 1 : c
                    d = d + dist(i,k)^(1/(1-r));
                end
                F(i,j) = (dist(i,j)^(1/(1-r)))/d;
            end
        end
        %% update c
        G = F.^r;
        center = (G'*data')./(sum(G',2)*ones(1,size(data',2)));
        center = center';
        iter = iter + 1;
        dist = distfcm(data', center');
        obj_FCM(iter) = sum(sum((dist.^2).*(F.^r)));
        if (abs(obj_FCM(iter)-obj_FCM(iter-1)) < 10^-5)
            break;
        end    
    end
end