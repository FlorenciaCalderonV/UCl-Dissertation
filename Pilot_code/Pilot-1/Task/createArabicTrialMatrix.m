
function [trials] = createArabicTrialMatrix(trialMatrix,r,taskIdx)
 
    %Create a trial matrix for the arabic numeral task
    %10 stims presented on each trial. 5 will randomly be blue and 5 randomly orange
    %The numbers will be sampled randomly from a uniform distribution
    %The only constraint is that the mean value for orange/blue colours should not
    %be the same
    
    %%Params: 
    %trialMatrixFinal: A matrix with a row for each trial. For both
    %tasks.
    %r: an integer denoting the run
    %taskIdx: a vector of indices for the detection task trials within
    %trialMatrix Final


    %%
    
    % Column indices
    cRun = 1; cTask = 2; cStimNum1 = 3; cStimNum2 = 4; cStimNum3 = 5; cStimNum4 = 6; cStimNum5 = 7; 
    cStimNum6 = 8;cStimNum7 = 9;cStimNum8 = 10;cStimNum9 = 11;cStimNum10 = 12;
    cStimCol1 = 13;cStimCol2 = 14;cStimCol3 = 15;cStimCol4 = 16;cStimCol5 = 17;
    cStimCol6 = 18;cStimCol7 = 19;cStimCol8 = 20;cStimCol9 = 21;cStimCol10= 22;
    
    % Define all the runs to start with
    trialMatrix(taskIdx, cRun) = r;

    % Define task index (i.e. number or detection task?) dots = 1,
    % arabic = 2
    trialMatrix(taskIdx(1:end), cTask) = 2;
    
    
    %Define Number Sequence
    nTrials = length(taskIdx);
    numSeqs = [];
    colours = [];
    meanO = Inf;
    meanB = Inf;
    for trl = 1:nTrials
        numSeq = nan(1,10);
        or = unidrnd(6,1,5) - 1;
        bl = unidrnd(6,1,5) - 1;
        meanO = mean(or);
        meanB = mean(bl);
        while meanO == meanB
            or = unidrnd(6,1,5) - 1;
            bl = unidrnd(6,1,5) - 1;
            meanO = mean(or);
            meanB = mean(bl); 
        end
        blIdxs = randsample(10,5,false);
        orIdxs = setdiff(1:10,blIdxs);
        numSeq(blIdxs) = bl;
        numSeq(orIdxs) = or;
        numSeqs(trl,blIdxs) = bl;
        numSeqs(trl,orIdxs) = or;
        colours(trl,blIdxs) = 1;
        colours(trl,orIdxs) = 2;
        
    end
    
    
    trialMatrix(taskIdx,cStimNum1) = numSeqs(:,1);
    trialMatrix(taskIdx,cStimCol1) = colours(:,1);
    trialMatrix(taskIdx,cStimNum2) = numSeqs(:,2);
    trialMatrix(taskIdx,cStimCol2) = colours(:,2);
    trialMatrix(taskIdx,cStimNum3) = numSeqs(:,3);
    trialMatrix(taskIdx,cStimCol3) = colours(:,3);
    trialMatrix(taskIdx,cStimNum4) = numSeqs(:,4);
    trialMatrix(taskIdx,cStimCol4) = colours(:,4);
    trialMatrix(taskIdx,cStimNum5) = numSeqs(:,5);
    trialMatrix(taskIdx,cStimCol5) = colours(:,5);
    
    trialMatrix(taskIdx,cStimNum6) = numSeqs(:,6);
    trialMatrix(taskIdx,cStimCol6) = colours(:,6);
    trialMatrix(taskIdx,cStimNum7) = numSeqs(:,7);
    trialMatrix(taskIdx,cStimCol7) = colours(:,7);
    trialMatrix(taskIdx,cStimNum8) = numSeqs(:,8);
    trialMatrix(taskIdx,cStimCol8) = colours(:,8);
    trialMatrix(taskIdx,cStimNum9) = numSeqs(:,9);
    trialMatrix(taskIdx,cStimCol9) = colours(:,9);
    trialMatrix(taskIdx,cStimNum10) = numSeqs(:,10);
    trialMatrix(taskIdx,cStimCol10) = colours(:,10);
    
    trials = trialMatrix;

    
end