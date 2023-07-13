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
            trialMatrixTemp(idxR,3) = repmat([1;2;3;4],[Nt/4,1]); %Angle: 1 = 20 deg, 2 = 160 deg, 3 = 200 deg, 4 = 340 deg
            trialMatrixTemp(idxR,4) = repmat([1;1;1;1;2;2;2;2],[Nt/8,1]); %V/O: 1 = V; 2 = O
            trialMatrixTemp(idxR,5) = repmat([1;1;1;1;1;1;1;1;2;2;2;2;2;2;2;2],[Nt/16,1]); %Avatar Blue/Green: 1 = Blue, 2 = Green
            %shuffle trials
            shufIdx = idxR(randperm(length(idxR)));
            trialMatrix(shufIdx,:) = trialMatrixTemp(idxR,:);
            
        else %else V/O task first
            if ~mod(r,2)
                trialMatrixTemp(idxR,2) = 2; %2 = V/O task
            else
                trialMatrixTemp(idxR,2) = 1; %1 = L/R task
            end
            trialMatrixTemp(idxR,3) = repmat([1;2;3;4],[Nt/4,1]); %Angle: 1 = 20 deg, 2 = 160 deg, 3 = 200 deg, 4 = 340 deg
            trialMatrixTemp(idxR,4) = repmat([1;1;1;1;2;2;2;2],[Nt/8,1]); %L/R: 1 = L; 2 = R
            trialMatrixTemp(idxR,5) = repmat([1;1;1;1;1;1;1;1;2;2;2;2;2;2;2;2],[Nt/16,1]); %Avatar Blue/Green: 1 = Blue, 2 = Green
            %shuffle trials
            shufIdx = idxR(randperm(length(idxR)));
            trialMatrix(shufIdx,:) = trialMatrixTemp(idxR,:);
          
        end
        
    end
    
       
end

