function [ trialMatrix]  = getTrialStructure(Nt,Nr,order)
% 
% nT number of trials per run combining both tasks
% nR number of runs
% (counterbalancing)


%Creates a trial matrix with two different tasks in each block
%The order of which task comes first is entered as a parameter.
%Order of tasks alternates after first task as blocks progress.
    

    % Trial Matrix (Trials for every run)
    trialMatrixTemp = zeros(Nt * Nr, 5);

       
    % fill in the trial matrix 
    for  r = 1:Nr
        idxR = 1 + (Nt*(r-1)):r * Nt; %define tasks' runs
        trialMatrixTemp(idxR,1) = r;
        
        if order == 1 %counterbalancing makes L/R first
            if mod(r,2)
                trialMatrixTemp(idxR,2) = 2; %2 = V/O task
            else
                trialMatrixTemp(idxR,2) = 1; %1 = L/R task
            end
            formations = [[1;1;1;1;1;1;1;1],[2;2;2;2;2;2;2;2],[3;3;3;3;3;3;3;3],[4;4;4;4;4;4;4;4]];
            cols = size(formations,2);
            P = randperm(cols);
            B = formations(:,P);
            disp(B)
            trialMatrixTemp(idxR,3) = B(:); %Formation: 1 = blue bottom-left, 2 = blue-top-left, 3 = blue top-right, 4 = blue bottom-right
            trialMatrixTemp(idxR,4) = repmat([1;2],[Nt/2,1]); %Angle of Avatar of Interest: 1 = small, 2 = big 
            trialMatrixTemp(idxR,5) = repmat([1;1;2;2],[Nt/4,1]); %V/O: 1 = V, 2 = O
            %shuffle trials
            lenMiniBlock = 8;
            idx = [randperm(lenMiniBlock) randperm(lenMiniBlock)+lenMiniBlock randperm(lenMiniBlock)+lenMiniBlock*2 randperm(lenMiniBlock)+lenMiniBlock*3];
            trialMatrix(idxR,:) = trialMatrixTemp(idxR(idx), :);
            
        else %else V/O task first
            if ~mod(r,2)
                trialMatrixTemp(idxR,2) = 2; %2 = V/O task
            else
                trialMatrixTemp(idxR,2) = 1; %1 = L/R task
            end
            formations = [[1;1;1;1;1;1;1;1],[2;2;2;2;2;2;2;2],[3;3;3;3;3;3;3;3],[4;4;4;4;4;4;4;4]];
            cols = size(formations,2);
            P = randperm(cols);
            B = formations(:,P);
            disp(B);

            trialMatrixTemp(idxR,3) = B(:);            
            trialMatrixTemp(idxR,4) = repmat([1;2],[Nt/2,1]); %Angle of Avatar of Interest: 1 = small, 2 = big 
            trialMatrixTemp(idxR,5) = repmat([1;1;2;2],[Nt/4,1]); %L/R: 1 = L, 2 = R
            %shuffle trials

            lenMiniBlock = 8;
            idx = [randperm(lenMiniBlock) randperm(lenMiniBlock)+lenMiniBlock randperm(lenMiniBlock)+lenMiniBlock*2 randperm(lenMiniBlock)+lenMiniBlock*3];
            trialMatrix(idxR,:) = trialMatrixTemp(idxR(idx), :);
        end
            
        
    end
       
end

