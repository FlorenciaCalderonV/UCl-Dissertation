
tic     
% newMain 
clear all; close all;

global w  
global params
global setTrigger          
global environment



%% 1. Ask for name and block number
subj = input('Subject number?: ', 's');

block = input('Block number?: ');
 
order = mod(subj,2)+1; %counterbalance order done by participant number

setTrigger = input('Send triggers? (1): ');

environment = input('Environment?: Instructions = 1, Main = 2');
  


%% 2. Set preferences and open screen

% Set different random seed for each run
rng('shuffle');

% Open psychtoolbox
[w,rect] = setWindow(0); %1 for debugging

ShowCursor;
 
% Define Parameters 

params = loadPars(rect, subj, block);


%% 2. Run number task instructions and practice
if isequal(environment, 1)
    showInstructions();
	sca;
	a = aaa; % Prevent main block from 1starting automatically
end


%% 2. Run
% Make balanced trial matrix in first run then load it for the rest
if  isequal(environment,2)
    if block == 0 %block zero pre-creates trial matrix
        [ trialMatrix ] = getTrialStructure(params.Ntrials, params.Nruns, order);
        disp(size(trialMatrix))
        save(fullfile(params.resultsDir, 'trialMatrix.mat'), 'trialMatrix');
        sca; 
        a = aaa;
    end
        
    
end



% Start the block  
if isequal(environment,2)
    
    for i = 1:params.Nruns
        if block > 0  
            load(fullfile(params.resultsDir, 'trialMatrix.mat'));
        end
        % Load and randomise the jittered ITI
        params.ITI = load('MEG_Jitter'); %unifrom distributed between 500 and 1000ms
        params.ITI = params.ITI.ITI;
        params.ITI = params.ITI(randperm(length(params.ITI)));

        trialMatrix = trialMatrix(trialMatrix(:,1)==params.block_num,:); %select block
        results = oneBlock(trialMatrix);
        
        params.block_num = params.block_num + 1;
        
    end
    %sca;
    %a = aaa;
end

% Close everything
sca;
