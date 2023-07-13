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
tooSlowWarning = 2;
feedbackTime = 0.3;
snip = 5/feedbackTime;
responseLimit = 2;
cueTime = 0.75;
changePositionTime = 2.5;
 
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

%too slow warning
[too_slow_warning, slow_freq] = psychwavread('stims/too_slow.wav');



%% STIMS 
   
for iTrial = 1:params.Ntrials
   
    if trials(iTrial,2) == 1 %L/R task

        if trials(iTrial,3:5) == [1,1,1]
            colour = '20_B_L.png';
            stim_name = 'fm1_li2.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [1,1,2]
            colour = '20_B_R.png';
            stim_name = 'fm1_li4.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [2,1,1]
            colour = '340_G_L.png';
            stim_name = 'fm2_li1.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [2,1,2]
            colour = '340_G_R.png';
            stim_name = 'fm2_li3.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,2,1]
            colour = '160_B_L.png';
            stim_name = 'fm2_li3.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [2,2,2]
            colour = '160_B_R.png';
            stim_name = 'fm2_li1.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [1,2,1]
            colour = '200_G_L.png';
            stim_name = 'fm1_li4.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [1,2,2]
            colour = '200_G_R.png';
            stim_name = 'fm1_li2.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [3,1,1]
            colour = '20_G_L.png';
            stim_name = 'fm3_li2.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [3,1,2]
            colour = '20_G_R.png';
            stim_name = 'fm3_li4.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [4,1,1]
            colour = '340_B_L.png';
            stim_name = 'fm4_li1.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [4,1,2]
            colour = '340_B_R.png';
            stim_name = 'fm4_li3.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,2,1]
            colour = '160_G_L.png';
            stim_name = 'fm4_li3.png';
            LEDon = 'D11';
        elseif trials(iTrial,3:5) == [4,2,2]
            colour = '160_G_R.png';
            stim_name = 'fm4_li1.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [3,2,1]
            colour = '200_B_L.png';
            stim_name = 'fm3_li4.png';
            LEDon = 'D10';
        elseif trials(iTrial,3:5) == [3,2,2]
            colour = '200_B_R.png';
            stim_name = 'fm3_li2.png';
            LEDon = 'D11';
        end
        
    elseif trials(iTrial,2) == 2 %V/O task
        if trials(iTrial,3:5) == [1,1,1]
            colour = '20_B_F.png';
            stim_name = 'fm1_li1.png';
            LEDon = 'D13';
        elseif trials(iTrial,3:5) == [1,1,2]
            colour = '20_B_B.png';
            stim_name = 'fm1_li3.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [2,1,1]
            colour = '340_G_F.png';
            stim_name = 'fm2_li4.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [2,1,2]
            colour = '340_G_B.png';
            stim_name = 'fm2_li2.png';
            LEDon = 'D13';
        elseif trials(iTrial,3:5) == [2,2,1]
            colour = '160_B_F.png';
            stim_name = 'fm2_li2.png';
            LEDon = 'D13';
        elseif trials(iTrial,3:5) == [2,2,2]
            colour = '160_B_B.png';
            stim_name = 'fm2_li4.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [1,2,1]
            colour = '200_G_F.png';
            stim_name = 'fm1_li3.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [1,2,2]
            colour = '200_G_B.png';
            stim_name = 'fm1_li1.png';
            LEDon = 'D13';
        elseif trials(iTrial,3:5) == [3,1,1]
            colour = '20_G_F.png';
            stim_name = 'fm3_li1.png';
            LEDon = 'D13';
        elseif trials(iTrial,3:5) == [3,1,2]
            colour = '20_G_B.png';
            stim_name = 'fm3_li3.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [4,1,1]
            colour = '340_B_F.png';
            stim_name = 'fm4_li4.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [4,1,2]
            colour = '340_B_B.png';
            stim_name = 'fm4_li2.png';
            LEDon = 'D13';
        elseif trials(iTrial,3:5) == [4,2,1]
            colour = '160_G_F.png';
            stim_name = 'fm4_li2.png';
            LEDon = 'D13';
        elseif trials(iTrial,3:5) == [4,2,2]
            colour = '160_G_B.png';
            stim_name = 'fm4_li4.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [3,2,1]
            colour = '200_B_F.png';
            stim_name = 'fm3_li3.png';
            LEDon = 'D12';
        elseif trials(iTrial,3:5) == [3,2,2]
            colour = '200_B_B.png';
            stim_name = 'fm3_li1.png';
            LEDon = 'D13';
        end
        
    end
    
    stim_names{iTrial} = stim_name;
    colours{iTrial} = colour;
    
    stimulus_path = fullfile('stims',  'final', stim_name);

    stimulus = imread(stimulus_path);
    stimulus = im2uint8(stimulus);

    stimuli(iTrial) = Screen('MakeTexture', w, stimulus, [], [], []);
    
    %blank stimulus
    bstimulus_path = fullfile('stims',  'final', strcat(stim_name(1:3),'_blank.png'));
    bstimulus = imread(bstimulus_path);
    bstimulus = im2uint8(bstimulus);
    bstimuli(iTrial) = Screen('MakeTexture', w, bstimulus, [], [], []);
    
    
    
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
    'You will now be reporting whether the light is on the LEFT or the RIGHT of the people in front of you.\n\n'...
    'Remember, before you see the image you will be told which person''s view you should report.\n\n '...
    'You must respond as quickly as possible, or you will hear a warning, \n and the lights on the table will flash.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report LEFT by pressing J.\n\n',...
    'Report RIGHT by pressing K.\n\n',...
    'Press any key to bgin.'
    ];
elseif trials(1,2) == 2 %If V/O task
    text = [
    'You will now be reporting whether the light is VISIBLE or HIDDEN for the people.\n\n'...
    'Remember, before you see the image you will be told which person''s view you should report.\n\n '...
    'You must respond as quickly as possible, or you will hear a warning, \n and the lights on the table will flash.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report VISIBLE by pressing J.\n\n',...
    'Report HIDDEN by pressing K.\n\n',...
    'Press any key to begin.'
    ];
end
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;
currTime = GetSecs;



%{
%black out screen for real life experiment
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
Screen('FillRect', w, [0 0 0 0]);
Screen('Flip', w);
%}

% Initial Fixation
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
results.presTime(iTrial,1) = Screen('Flip', w, currTime - params.halfFrame);

currTime = currTime + initialWait;


for iTrial = 1:params.Ntrials
    
    
    
    if ismember(iTrial,[9,17,25]) 
       %pause before miniblocks begin
       WaitSecs(0.5);
       DrawFormattedText(w, 'CHANGING POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       WaitSecs(changePositionTime);
       currTime = GetSecs;
    end
    
    bstim = bstimuli(iTrial);
    Screen('DrawTexture', w, bstim);
    results.presTime(iTrial,1) = Screen('Flip', w, currTime - params.halfFrame);

    currTime = currTime + params.ITI(iTrial);
    WaitSecs(params.ITI(iTrial));
    stim = stimuli(iTrial);
    
    %Get LED
    LEDon = LEDs{iTrial};
    
    
    
    %play auditory cue
    if contains(colours{iTrial},'_B_')
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
   
    %%writeDigitalPin(a, LEDon, 1);

    
    tempTime = GetSecs;
    pressed = false;
    while GetSecs - tempTime < responseLimit
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs -  results.presTime(iTrial, 2);
            if strcmp(KbName(response),'j') %if responded with left key
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
            elseif strcmp(KbName(response),'k')
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
                for i = 1:8
                    %writeDigitalPin(a, 'D10', 1);
                    %writeDigitalPin(a, 'D11', 1);
                    %writeDigitalPin(a, 'D12', 1);
                    %writeDigitalPin(a, 'D13', 1);
                    %writeDigitalPin(a, 'D10', 0);
                    %writeDigitalPin(a, 'D11', 0);
                    %writeDigitalPin(a, 'D12', 0);
                    %writeDigitalPin(a, 'D13', 0);
                end
                Screen('Flip', w,currTime-params.halfFrame);
                DrawFormattedText(w, 'WRONG KEY!','center', 'center', [255 0 0]);
                Screen('Flip', w,currTime-params.halfFrame);
                currTime = currTime + tooSlowWarning;
                Screen('TextSize',w, 24);

                break
            end
        end
    end
    if pressed == false
        currTime = currTime + responseLimit;
        disp('Too Slow!')
        %Screen('TextSize',w, 50);
        %sound(too_slow_warning,slow_freq)

        for i = 1:8
            %writeDigitalPin(a, 'D10', 1);
            %writeDigitalPin(a, 'D11', 1);
            %writeDigitalPin(a, 'D12', 1);
            %writeDigitalPin(a, 'D13', 1);
            %writeDigitalPin(a, 'D10', 0);
            %writeDigitalPin(a, 'D11', 0);
            %writeDigitalPin(a, 'D12', 0);
            %writeDigitalPin(a, 'D13', 0);
        end
        Screen('Flip', w,currTime-params.halfFrame);
        %DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);

        
        
        currTime = currTime + tooSlowWarning;
        
       

        

    end

    %turn off led
    %writeDigitalPin(a, LEDon, 0);

    %% Overwrite results each trial to ensure it still saves on crash
    save(outFile, 'results', 'trials', 'params');
    
end



end



