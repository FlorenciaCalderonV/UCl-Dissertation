function results = oneBlock(trials)
% Function to present one block of trials.


global w
global params
global setTrigger


outFile = fullfile(params.resultsDir, sprintf('results_block_%d.mat', params.block_num));

%% Set Up
%General
initialWait = 1;
tooSlowWarning = 1;
feedbackTime = 0.3;
responseLimit = 1.5;
 
%feedback tones
[correct_tone, correct_freq] = psychwavread('stims/correct_tone.wav');
cor_wavedata = correct_tone';


[incorrect_tone, incorrect_freq] = psychwavread('stims/incorrect_tone.wav');
incor_wavedata = incorrect_tone';

nrchannels = size(incor_wavedata,1); % Number of rows == number of channels.

%% STIMS 
   
for iTrial = 1:params.Ntrials
   
    if trials(iTrial,2) == 1 %L/R task

        if trials(iTrial,3:5) == [1,1,1]
            stim_name = 'rot60drwhoL.jpg';

        elseif trials(iTrial,3:5) == [1,1,2]
            stim_name = 'rot300drwhoL.jpg';

        elseif trials(iTrial,3:5) == [2,1,1]
            stim_name = 'rot160drwhoL.jpg';
            
        elseif trials(iTrial,3:5) == [2,1,2]
            stim_name = 'rot200drwhoL.jpg';
            
        elseif trials(iTrial,3:5) == [2,2,1]
            stim_name = 'rot160drwhoR.jpg';
            
        elseif trials(iTrial,3:5) == [2,2,2]
            stim_name = 'rot200drwhoR.jpg';
            
        elseif trials(iTrial,3:5) == [1,2,1]
            stim_name = 'rot60drwhoR.jpg';
            
        elseif trials(iTrial,3:5) == [1,2,2]
            stim_name = 'rot300drwhoR.jpg';
            
        end
        
    elseif trials(iTrial,2) == 2 %V/O task
        
        if trials(iTrial,3:5) == [1,1,1]
            stim_name = 'rot60drwhoF.jpg';

        elseif trials(iTrial,3:5) == [1,1,2]
            stim_name = 'rot300drwhoF.jpg';

        elseif trials(iTrial,3:5) == [2,1,1]
            stim_name = 'rot160drwhoF.jpg';
            
        elseif trials(iTrial,3:5) == [2,1,2]
            stim_name = 'rot200drwhoF.jpg';
            
        elseif trials(iTrial,3:5) == [2,2,1]
            stim_name = 'rot160drwhoB.jpg';
            
        elseif trials(iTrial,3:5) == [2,2,2]
            stim_name = 'rot200drwhoB.jpg';
            
        elseif trials(iTrial,3:5) == [1,2,1]
            stim_name = 'rot60drwhoB.jpg';
            
        elseif trials(iTrial,3:5) == [1,2,2]
            stim_name = 'rot300drwhoB.jpg';
            
        end
            
        
    end

    stimulus_path = fullfile('stims',  stim_name);

    stimulus = imread(stimulus_path);

    stimuli(iTrial) = Screen('MakeTexture', w, stimulus, [], [], []);

end


% Start of the block
results.startTime = waitForTrigger();
DisableKeysForKbCheck(KbName('5%'));


%% Start of presentation
%present initial miniblock/hand instructions
    
%audio
audio_incorrect = PsychPortAudio('Open', [], [], 0, incorrect_freq, nrchannels);
PsychPortAudio('FillBuffer', audio_incorrect, incor_wavedata);

audio_correct = PsychPortAudio('Open', [], [], 0, correct_freq, nrchannels);
PsychPortAudio('FillBuffer', audio_correct, cor_wavedata);
tmp_time = GetSecs;
PsychPortAudio('Start', audio_correct, 1,tmp_time,[],tmp_time+0.01 ,[]); %this here because first tone never plays (??), so put dummy tone here that we're not interested in

results.presTime = zeros(params.Ntrials,2);

%% Pre-Block Instructions
%Timing
currTime = GetSecs;
if trials(1,2) == 1 %If L/R task
    text = [
    'You will now be reporting whether the light is on the left or the right of the man.\n\n'...
    'You must respond as quickly as possible, or you will be presented with a warning.\n\n',...
    'You should use your LEFT HAND to respond\n\n',...
    'Report LEFT by pressing 1.\n\n',...
    'Report RIGHT by pressing 2.\n\n',...
    'Press any key to continue.'
    ];
elseif trials(1,2) == 2 %If V/O task
    text = [
    'You will now be reporting whether the light is visible or hidden for the man.\n\n'...
    'You must respond as quickly as possible, or you will be presented with a warning.\n\n',...
    'You should use your LEFT HAND to respond\n\n',...
    'Report VISIBLE by pressing 1.\n\n',...
    'Report HIDDEN by pressing 2.\n\n',...
    'Press any key to continue.'
    ];
end
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;
currTime = GetSecs;


% Initial Fixation
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
results.presTime(iTrial,1) = Screen('Flip', w, currTime - params.halfFrame);

currTime = currTime + initialWait;

for iTrial = 1:params.Ntrials
    
    % Fixation during variable ITI
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    results.presTime(iTrial,1) = Screen('Flip', w, currTime - params.halfFrame);

    currTime = currTime + params.ITI(iTrial);

    %currTime = currTime + fixDur;
    stim = stimuli(iTrial);

    % Present the stimulus

    Screen('DrawTexture', w, stim);

    if setTrigger % Send MEG trigger
        %t0 = time;
        %waituntil(t0 + trigger.nullTime)
        %outportb(trigger.port, trigger.null)
        Screen('FillRect', w, 0, params.diodeRect);
        results.presTime(iTrial, 2) = Screen('Flip', w, currTime - params.halfFrame);
        %             outportb(trigger.port, trigger.stimOnset);
        io64(params.trigger.object,params.trigger.scanport,1);
         %com = IOPort('OpenSerialPort', 'COM3');
         %IOPort('Write', com, uint8(trigger.cueOnset));

    else
        results.presTime(iTrial, 2) = Screen('Flip', w, currTime - params.halfFrame);
    end
    
    
    tempTime = GetSecs;
    pressed = false;
    while GetSecs - tempTime < responseLimit
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs -  results.presTime(iTrial, 2);
            if strcmp(KbName(response),'1!') %if responded with left key
                results.resp(iTrial) = 1;
                results.RTs(iTrial) = RT;
                if trials(iTrial,4) == 1
                    results.correct(iTrial) = 1; 
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+feedbackTime ,[]);
                     disp('correct')
                else
                    results.correct(iTrial) = 0;
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+feedbackTime ,[]);
                     disp('incorrect')

                end
                currTime = currTime + RT + feedbackTime;
                break
            elseif strcmp(KbName(response),'2@')
                results.resp(iTrial) = 2;
                results.RTs(iTrial) = RT;
                if trials(iTrial,4) == 2
                    results.correct(iTrial) = 1; %put in feedback tone
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+feedbackTime ,[]);
                     disp('correct')

                else
                    results.correct(iTrial) = 0;
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+feedbackTime ,[]);
                     disp('incorrect')

                end
                currTime = currTime+ RT + feedbackTime;
                break
            elseif strcmp(KbName(response),'ESCAPE') % Press escape to close all
                    Screen('CloseAll');
            else
                currTime = currTime + RT;
                Screen('TextSize',w, 50);
                Screen('Flip', w,currTime-params.halfFrame);
                DrawFormattedText(w, 'WRONG KEY!','center', 'center', [255 0 0]);
                Screen('Flip', w,currTime-params.halfFrame);
                currTime = currTime + tooSlowWarning;
                break
            end
        end
    end
    if pressed == false
        currTime = currTime + responseLimit;
        disp('Too Slow!')
        Screen('TextSize',w, 50);

        Screen('Flip', w,currTime-params.halfFrame);
        DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);
        currTime = currTime + tooSlowWarning;
    end

   
    %% Overwrite results each trial to ensure it still saves on crash
    save(outFile, 'results', 'trials', 'params');
    
    
end



end



