function [trials] = createDotTrialMatrix(trialMatrixFinal,r,taskIdx)
    
        % Fills the trialMatrix with trials for the numerical task
        %The number of sample numerosities is equally spread
        %There are 50% match trials and 50% non-match
        %The non-match trials are equally proportioned
        %e.g. 0-1, 0-2, 0-3 all occur the same number of times
        %The order of the trials is randomised before returning.
        %Number of trials should be multiple of 4 and 6 (e.g. 48) for even 
        %number of each numerosities.
        
        %%Params: 
        %trialMatrixFinal: A matrix with a row for each trial. For both
        %tasks.
        %r: an integer denoting the run
        %taskIdx: a vector of indices for the numerical task trials within
        %trialMatrix Final
        
        %%
        % Column indices
        cRun = 1; cTask = 2; cStimSet = 3; cSample = 4; cTest = 5; 
        
        %create duplicate trial matrix that we can fill and then
        %shuffle trials before adding to final trial matrix.
        %This is so we don't shuffle across different tasks
        trialMatrix = zeros(size(trialMatrixFinal));
        
        %label run column
        trialMatrix(taskIdx, cRun) = r;

        % Define task index (i.e. dot or arabic task?) dot = 1,
        % arabic = 2
        trialMatrix(taskIdx(1:end), cTask) = 1;
        
      
        % 25% trials each sample number
        end0 = 9;
        end1 = end0+9;
        end2 = end1+9;
        end3 = end2+9;
        end4 = end3+9;
        end5 = end4+9;
        
        trialMatrix(taskIdx(1:end0), cSample) = 0; %0s
        trialMatrix(taskIdx(end0+1:end1), cSample) = 1; %1s
        trialMatrix(taskIdx(end1+1:end2), cSample) = 2; %2s
        trialMatrix(taskIdx(end2+1:end3), cSample) = 3; %3s
        trialMatrix(taskIdx(end3+1:end4), cSample) = 4; %4s
        trialMatrix(taskIdx(end4+1:end5), cSample) = 5; %5s
        
        %set which stim set (control/standard)
        if mod(r,2) ~= 0
            trialMatrix(taskIdx(1), cStimSet) = 1;
            for i = 1:length(taskIdx)
                if i > 1
                    if trialMatrix(taskIdx(i),cSample) ~= trialMatrix(taskIdx(i-1),cSample)
                        trialMatrix(taskIdx(i), cStimSet) = 1;
                        continue
                    end
                    if trialMatrix(taskIdx(i-1),cStimSet) == 1
                        trialMatrix(taskIdx(i), cStimSet) = 2;
                    elseif trialMatrix(taskIdx(i-1),cStimSet) == 2
                        trialMatrix(taskIdx(i), cStimSet) = 1;
                    end
                end
            end
        else
            trialMatrix(taskIdx(1), cStimSet) = 2;
            for i = 1:length(taskIdx)
                if i > 1
                    if trialMatrix(taskIdx(i),cSample) ~= trialMatrix(taskIdx(i-1),cSample)
                        trialMatrix(taskIdx(i), cStimSet) = 2;
                        continue
                    end
                    if trialMatrix(taskIdx(i-1),cStimSet) == 1
                        trialMatrix(taskIdx(i), cStimSet) = 2;
                    elseif trialMatrix(taskIdx(i-1),cStimSet) == 2
                        trialMatrix(taskIdx(i), cStimSet) = 1;
                    end
                end
            end
        end
        
        
        %Test Numbers: 24 match trials, 30 non-match, this allows us to have 
        %one sample-test numerosity combo for non-match trials in each block
        zeroIdx = find(trialMatrix(taskIdx,cSample)==0); %find trials with 0 as sample number
        oneIdx = find(trialMatrix(taskIdx,cSample)==1); %find trials with 1 as sample number
        twoIdx = find(trialMatrix(taskIdx,cSample)==2);
        threeIdx = find(trialMatrix(taskIdx,cSample)==3);
        fourIdx  = find(trialMatrix(taskIdx,cSample)==4);
        fiveIdx = find(trialMatrix(taskIdx,cSample)==5);
        idxs = {zeroIdx;oneIdx;twoIdx;threeIdx;fourIdx;fiveIdx};
        
        
        non_match_zero = [ 1 2 3 4 5];
        non_match_one = [2 3 4 5 0];
        non_match_two = [3 4 5 0 1];
        non_match_three = [4 5 0 1 2];
        non_match_four = [5 0 1 2 3];
        non_match_five = [0 1 2 3 4];
        non_matches = {non_match_zero,non_match_one,non_match_two,non_match_three,non_match_four,non_match_five};
        
        match_num = 0; %set matching number depending on sample number
        for i = 1:length(idxs)
            idx = idxs{i};
            non_match = non_matches{i};
            trialMatrix(taskIdx(idx(1:4)),cTest) = match_num; % 50% match trials
            trialMatrix(taskIdx(idx(5)),cTest) = non_match(1); %then 1/3 rest of trials non match 
            trialMatrix(taskIdx(idx(6)),cTest) = non_match(2); 
            trialMatrix(taskIdx(idx(7)),cTest) = non_match(3); 
            trialMatrix(taskIdx(idx(8)),cTest) = non_match(4); 
            trialMatrix(taskIdx(idx(9)),cTest) = non_match(5); 

            match_num = match_num + 1; %update match number
        end

       
        %randomise trial order
        numTrialMatrix = trialMatrix(any(trialMatrix, 2) ,:); %remove blank rows (these will be filled by other task)
        shuffNumTrials =  numTrialMatrix(randperm(size(numTrialMatrix, 1)), :);%randomise numerical task trials

        
        %add back to the final trial matrix
        trialMatrixFinal(taskIdx,:) = shuffNumTrials;
        trials = trialMatrixFinal;
        
end
