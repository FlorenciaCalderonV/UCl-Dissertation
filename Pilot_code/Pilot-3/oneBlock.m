function results = oneBlock(trials)
% Function to present one block of trials.


global w
global params
global setTrigger
%global a


outFile = fullfile(params.resultsDir, sprintf('results_block_%d.mat', params.block_num));

%% Set Up
%General
initialWait = 1;
tooSlowWarning = 1;
feedbackTime = 0.3;
snip = 5/feedbackTime;
responseLimit = 2;
cueTime = 0.75;
 
%feedback tones
[correct_tone, correct_freq] = psychwavread('stims/correct_tone.wav');
correct_tone = correct_tone(1:length(correct_tone)/snip,:); 

[incorrect_tone, incorrect_freq] = psychwavread('stims/incorrect_tone.wav');
incorrect_tone = incorrect_tone(1:length(incorrect_tone)/snip,:);

%cue tones
[blue_tone, blue_freq] = psychwavread('stims/speech_blue.wav');
blue_wavedata = blue_tone';

[green_tone, green_freq] = psychwavread('stims/speech_green.wav');
green_wavedata = green_tone';


%% STIMS 
   
for iTrial = 1:params.Ntrials
   
    if trials(iTrial,2) == 1 %L/R task

        if trials(iTrial,3:5) == [1,1,1]
            stim_name = '20_B_L.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [1,1,2]
            stim_name = '20_B_R.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,1,1]
            stim_name = '340_G_L.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [2,1,2]
            stim_name = '340_G_R.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,2,1]
            stim_name = '160_B_L.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,2,2]
            stim_name = '160_B_R.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [1,2,1]
            stim_name = '200_G_L.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [1,2,2]
            stim_name = '200_G_R.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [3,1,1]
            stim_name = '20_G_L.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [3,1,2]
            stim_name = '20_G_R.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,1,1]
            stim_name = '340_B_L.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [4,1,2]
            stim_name = '340_B_R.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,2,1]
            stim_name = '160_G_L.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,2,2]
            stim_name = '160_G_R.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [3,2,1]
            stim_name = '200_B_L.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [3,2,2]
            stim_name = '200_B_R.png';
            LEDon = 'D3';
        end
        
    elseif trials(iTrial,2) == 2 %V/O task
        if trials(iTrial,3:5) == [1,1,1]
            stim_name = '20_B_F.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [1,1,2]
            stim_name = '20_B_B.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,1,1]
            stim_name = '340_G_F.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [2,1,2]
            stim_name = '340_G_B.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,2,1]
            stim_name = '160_B_F.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,2,2]
            stim_name = '160_B_B.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [1,2,1]
            stim_name = '200_G_F.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [1,2,2]
            stim_name = '200_G_B.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [3,1,1]
            stim_name = '20_G_F.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [3,1,2]
            stim_name = '20_G_B.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,1,1]
            stim_name = '340_B_F.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [4,1,2]
            stim_name = '340_B_B.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,2,1]
            stim_name = '160_G_F.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,2,2]
            stim_name = '160_G_B.png';
            LEDon = 'D3';
        elseif trials(iTrial,3:5) == [3,2,1]
            stim_name = '200_B_F.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [3,2,2]
            stim_name = '200_B_B.png';
            LEDon = 'D3';
        end
        
    end
    stim_names{iTrial} = stim_name;
    
    stimulus_path = fullfile('stims',  'dual', stim_name);

    stimulus = imread(stimulus_path);

    stimuli(iTrial) = Screen('MakeTexture', w, stimulus, [], [], []);
    
    LEDs{iTrial} = LEDon;

end


% Start of the block
results.startTime = waitForTrigger();
DisableKeysForKbCheck(KbName('5%'));


%% Start of presentation
%present initial miniblock/hand instructions
    

results.presTime = zeros(params.Ntrials,2);

%% Pre-Block Instructions
%Timing
currTime = GetSecs;
if trials(1,2) == 1 %If L/R task
    text = [
    'You will now be reporting whether the light is on the left or the right of the men.\n\n'...
   'Remember, before you see the image you will be told which mans view you should report.\n\n '...
    'You must respond as quickly as possible, or you will be presented with a warning.\n\n',...
    'You should use your LEFT HAND to respond\n\n',...
    'Report LEFT by pressing 1.\n\n',...
    'Report RIGHT by pressing 2.\n\n',...
    'Press any key to continue.'
    ];
elseif trials(1,2) == 2 %If V/O task
    text = [
    'You will now be reporting whether the light is visible or hidden for the men.\n\n'...
    'Remember, before you see the image you will be told which mans view you should report.\n\n '...
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
    
    %Get LED
    LEDon = LEDs{iTrial};
    
    % Fixation during variable ITI
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    results.presTime(iTrial,1) = Screen('Flip', w, currTime - params.halfFrame);

    currTime = currTime + params.ITI(iTrial);
    WaitSecs(params.ITI(iTrial));
    stim = stimuli(iTrial);
    
    %play auditory cue
    if contains(stim_names{iTrial},'_B_')
       sound(blue_tone,blue_freq)
    else
       sound(green_tone,green_freq)
    end
    
    currTime = currTime + cueTime;

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
    %writeDigitalPin(a, LEDon, 1);

    
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
                if trials(iTrial,5) == 1
                    results.correct(iTrial) = 1; 
                    sound(correct_tone,correct_freq)
                else
                     results.correct(iTrial) = 0;
                     sound(incorrect_tone,incorrect_freq)

                     disp('incorrect')

                end
                currTime = currTime + RT + feedbackTime;

                break
            elseif strcmp(KbName(response),'2@')
                results.resp(iTrial) = 2;
                results.RTs(iTrial) = RT;
                if trials(iTrial,5) == 2
                    results.correct(iTrial) = 1; %put in feedback tone
                    sound(correct_tone,correct_freq)
                    disp('correct')

                else
                    results.correct(iTrial) = 0;
                    sound(incorrect_tone,incorrect_freq)
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

    %turn off led
    %writeDigitalPin(a, LEDon, 0);

    %% Overwrite results each trial to ensure it still saves on crash
    save(outFile, 'results', 'trials', 'params');
    
end



end



