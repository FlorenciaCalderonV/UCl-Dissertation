function [ results ] = showInstructions()


global w
global params

responseLimit = 1.5;
tooSlowWarning = 1;
currTime = GetSecs;
feedbackTime = 0.3;
snip = 5/feedbackTime;

%feedback tones
[correct_tone, correct_freq] = psychwavread('stims/correct_tone.wav');
cor_wavedata = correct_tone';


[incorrect_tone, incorrect_freq] = psychwavread('stims/incorrect_tone.wav');
incor_wavedata = incorrect_tone';
nrchannels = size(incor_wavedata,1); % Number of rows == number of channels.

correct_tone = correct_tone(1:length(correct_tone)/snip,:); 
incorrect_tone = incorrect_tone(1:length(incorrect_tone)/snip,:);

%cue tones
[blue_tone, blue_freq] = psychwavread('stims/speech_blue.wav');
blue_wavedata = blue_tone';

[green_tone, green_freq] = psychwavread('stims/speech_green.wav');
green_wavedata = green_tone';

Screen('TextSize',w, 28);
text = ['Thank you for participating in our study!\n\n', ...
         'This study is made up of two different - but very similar - tasks.\n\n',...
        'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);
KbStrokeWait;

%% Explain task
text = ['The main part of this experiment will be using a real-life set up.\n\n',...
    'However, to introduce the tasks, you will first learn them on the computer.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);
KbStrokeWait;


text = ['First, we will show you how to perform the Left or Right Task.\n\n',...
    'In this task, you will see an image of two people sat at a round table.\n\n'...
    'One person will be wearing green, the other will be wearing blue.\n\n'...
    'In each image, a light will be illuminated somewhere on the table.\n\n',...
    'Your job will be to decide, for each image, \nwhether the light is on the left or the right for either the blue person or the green person.\n\n'...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);
KbStrokeWait;
currTime = GetSecs();

text = ['Here are some examples of the images.\n\n',...
       'Press any key to continue.'] ;
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);
KbStrokeWait;

for i = 1:4
    Screen('TextSize',w, 30);

     if i == 1
        stimulus_path = fullfile('stims','final', 'fm3_li2.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the GREEN person, the light is on the LEFT';
    elseif i == 2
        stimulus_path = fullfile('stims','final', 'fm1_li2.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the GREEN person, the light is on the RIGHT';
    elseif i == 3
        stimulus_path = fullfile('stims', 'final','fm4_li1.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the BLUE person, the light is on the LEFT';
    elseif i == 4
        stimulus_path = fullfile('stims', 'final','fm2_li1.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the BLUE person, the light is on the RIGHT';
     end
    
    stimulus = Screen('MakeTexture', w, stimulus, [], [], []); 
    DrawFormattedText(w, sprintf(caption),'center',125, [255 255 255]);
    Screen('TextSize',w, 20);

    DrawFormattedText(w, 'Press any button to continue','center',800, [255 255 255]);

    Screen('DrawTexture', w, stimulus);
    Screen('Flip', w);
%     WaitSecs(0.5)
    KbStrokeWait;
end

%% Practice with no response limit, just for green person
Screen('TextSize',w,30);

text = [
    'First we will practice an easy version of the task.\n\n'...
    'In this practice version, there will be no time limit for you to respond.\n\n',...
    'You will first see the table with no lights on.\n\n',...
    'Different lights will then turn on one by one.\n\n',...
    'You will be asked whether the light is on the left or right of the GREEN person.\n\n',...
    'In this block just IGNORE the BLUE person.\n\n',...
    'You will hear a high pitch beep if you are correct, and a low beep if you are incorrect.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should use your RIGHT HAND to respond.\n\n',...
    'Report LEFT by pressing J.\n\n',...
    'Report RIGHT by pressing K.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should respond as quickly as you can once you see the light turn on.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

old_stims = {
'200_G_R.png'
'200_G_L.png'
'340_G_R.png'
'340_G_L.png'
'160_G_R.png'
'160_G_L.png'};

stims = {
'fm1_li2.png'
'fm1_li4.png'
'fm2_li3.png'
'fm2_li1.png'
'fm4_li1.png'
'fm4_li3.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    tempTime = GetSecs;
    pressed = false;
    while pressed == false
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_G_'),'L.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_G_'),'R.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
end


%% Practice with no response limit, just for blue
Screen('TextSize',w,30);

text = [
    'Now you will be asked whether the light is on the left or right of the BLUE person.\n\n',...
    'In this block just IGNORE the GREEN person.\n\n',...
    'You will hear a high pitch beep if you are correct, and a low beep if you are incorrect.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should use your RIGHT HAND to respond.\n\n',...
    'Report LEFT by pressing J.\n\n',...
    'Report RIGHT by pressing K.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should respond as quickly as you can once you see the light turn on.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

old_stims = {
'20_B_L.png'
'20_B_R.png'
'160_B_L.png'
'160_B_R.png'
'340_B_L.png'
'340_B_R.png'};

stims = {
'fm1_li2.png'
'fm1_li4.png'
'fm2_li3.png'
'fm2_li1.png'
'fm4_li1.png'
'fm4_li3.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    tempTime = GetSecs;
    pressed = false;
    while pressed == false
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_B_'),'L.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_B_'),'R.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
end

%% practice response limit for BLUE person

Screen('TextSize',w, 30);

text = [
    'Now we will practice the task with a time limit for your responses.\n\n'...
    'You must respond as quickly as possible, or you will be presented with a warning.\n\n',...
    'In this block, again just report whether the light is on the left or right for the BLUE person.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report LEFT by pressing J.\n\n',...
    'Report RIGHT by pressing K.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;
old_stims = {
'20_B_L.png'
'20_B_R.png'
'160_B_L.png'
'160_B_R.png'
'340_B_L.png'
'340_B_R.png'};

stims = {
'fm1_li2.png'
'fm1_li4.png'
'fm2_li3.png'
'fm2_li1.png'
'fm4_li1.png'
'fm4_li3.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    pressed = false;
    while GetSecs - stim_time < responseLimit        
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_B_'),'L.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_B_'),'R.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
     if pressed == false
        currTime = stim_time + responseLimit;
        disp('Too Slow!')
        Screen('TextSize',w, 50);

        Screen('Flip', w,currTime-params.halfFrame);
        DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);
        currTime = currTime + tooSlowWarning;
        WaitSecs(tooSlowWarning);

    end

end

%% practice response limit for GREEN person

Screen('TextSize',w, 30);

text = [
    'Now, just report whether the light is on the left or right for the GREEN person.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report LEFT by pressing J.\n\n',...
    'Report RIGHT by pressing K.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

old_stims = {
'200_G_R.png'
'200_G_L.png'
'340_G_R.png'
'340_G_L.png'
'160_G_R.png'
'160_G_L.png'};

stims = {
'fm1_li2.png'
'fm1_li4.png'
'fm2_li3.png'
'fm2_li1.png'
'fm4_li1.png'
'fm4_li3.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    pressed = false;
    while GetSecs - stim_time < responseLimit        
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_G_'),'L.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_G_'),'R.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
     if pressed == false
        currTime = stim_time + responseLimit;
        disp('Too Slow!')
        Screen('TextSize',w, 50);

        Screen('Flip', w,currTime-params.halfFrame);
        DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);
        currTime = currTime + tooSlowWarning;
        WaitSecs(tooSlowWarning);

    end

end

%% Practice with auditory cue
old_stims = {
'200_G_R.png'
'20_B_L.png'
'200_G_L.png'
'20_B_R.png'

'160_B_L.png'
'340_G_R.png'
'340_G_L.png'
'160_B_R.png'

'340_B_L.png'
'340_B_R.png'
'160_G_L.png'
'160_G_R.png'};

stims = {
'fm1_li2.png'
'fm1_li2.png'
'fm1_li4.png'
'fm1_li4.png'

'fm2_li3.png'
'fm2_li3.png'
'fm2_li1.png'
'fm2_li1.png'

'fm4_li1.png'
'fm4_li3.png'
'fm4_li3.png'
'fm4_li1.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm1_blank.png'
'fm1_blank.png'

'fm2_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm2_blank.png'

'fm4_blank.png'
'fm4_blank.png'
'fm4_blank.png'
'fm4_blank.png'

};


Screen('TextSize',w, 30);

text = [
    'Now, before you see each image, you will hear the word "BLUE" or "GREEN".\n\n',...
    'This will tell you whether to respond based on the blue or green persons perspective.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report LEFT by pressing J.\n\n',...
    'Report RIGHT by pressing K.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;

Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.75;
% WaitSecs(0.75);

for i = 1:12
    
    Screen('TextSize',w, 24);
    if any(ismember(i,[5,9]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 1.5;
    WaitSecs(0.75);
    
    
    if contains(old_stim_name,'B')
       sound(blue_tone,blue_freq)
       colour = 'blue';
    else
       sound(green_tone,green_freq)
       colour = 'green';
    end
    disp(colour)
    WaitSecs(0.75);
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    
    
    pressed = false;
    while GetSecs - stim_time < responseLimit
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp('blue', colour)
                    if strcmp(extractAfter(old_stim_name,'_B_'),'L.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                else
                    if strcmp(extractAfter(old_stim_name,'_G_'),'L.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                end
            elseif strcmp(KbName(response),'k')
                if strcmp('blue', colour)
                    if strcmp(extractAfter(old_stim_name,'_B_'),'R.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                else
                    if strcmp(extractAfter(old_stim_name,'_G_'),'R.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                end
            elseif strcmp(KbName(response),'ESCAPE') % Press escape to close all
                    Screen('CloseAll');
            else
                currTime = currTime + RT;
                Screen('TextSize',w, 50);
                Screen('Flip', w,currTime-params.halfFrame);
                DrawFormattedText(w, 'WRONG KEY!','center', 'center', [255 0 0]);
                Screen('Flip', w,currTime-params.halfFrame);
                currTime = currTime + tooSlowWarning;
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
    if pressed == false
        currTime = stim_time + responseLimit;
        disp('Too Slow!')
        Screen('TextSize',w, 50);

        Screen('Flip', w,currTime-params.halfFrame);
        DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);
        currTime = currTime + tooSlowWarning;
        WaitSecs(tooSlowWarning);

    end

end



%% practice V/O task
currTime = GetSecs;
Screen('TextSize',w, 30);
text = [
    'Good job! You''ll have another chance to practice before the main experiment.\n\n'...
    'Now, let''s learn about the next task.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

text = [
    'In this task, the images will look similar to those \n in the first task, but now the lights will be visible for one person and hidden for the other.\n\n'...
    'You will have to report whether the light is visible or hidden to either of the people.\n\n'...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

text = [
    'Here are some example images.\n\n'...
    'Press to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

for i = 1:4
    Screen('TextSize',w, 30);

     if i == 1
        stimulus_path = fullfile('stims','final', 'fm3_li3.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the GREEN person, the light is HIDDEN';
    elseif i == 2
        stimulus_path = fullfile('stims','final', 'fm3_li1.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the GREEN person, the light is VISIBLE';
    elseif i == 3
        stimulus_path = fullfile('stims', 'final','fm4_li4.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the BLUE person, the light is VISIBLE';
    elseif i == 4
        stimulus_path = fullfile('stims', 'final','fm4_li2.png'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        stimulus = im2uint8(stimulus);
        caption = 'For the BLUE person, the light is HIDDEN';
     end
    
    stimulus = Screen('MakeTexture', w, stimulus, [], [], []); 
    DrawFormattedText(w, sprintf(caption),'center',125, [255 255 255]);
    Screen('TextSize',w, 20);

    DrawFormattedText(w, 'Press any button to continue','center',800, [255 255 255]);

    Screen('DrawTexture', w, stimulus);
    Screen('Flip', w);
%     WaitSecs(0.5)
    KbStrokeWait;
end



Screen('TextSize',w,30);

text = [
    'First we will practice an easy version of the task.\n\n'...
    'In this practice version, there will be no time limit for you to respond.\n\n',...
    'You will first see the table with no lights on.\n\n',...
    'Different lights will then turn on one by one.\n\n',...
    'You will be asked whether the light is VISIBLE or HIDDEN for the GREEN person.\n\n',...
    'In this block just IGNORE the BLUE person.\n\n',...
    'You will hear a high pitch beep if you are correct, and a low beep if you are incorrect.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should use your RIGHT HAND to respond.\n\n',...
    'Report VISIBLE by pressing J.\n\n',...
    'Report HIDDEN by pressing K.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should respond as quickly as you can once you see the light turn on.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

old_stims = {
'200_G_F.png'
'200_G_B.png'
'340_G_F.png'
'340_G_B.png'
'160_G_F.png'
'160_G_B.png'};

stims = {
'fm1_li3.png'
'fm1_li1.png'
'fm2_li4.png'
'fm2_li2.png'
'fm4_li2.png'
'fm4_li4.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    tempTime = GetSecs;
    pressed = false;
    while pressed == false
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_G_'),'F.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_G_'),'B.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
end


%% Practice with no response limit, just for blue
Screen('TextSize',w,30);

text = [
    'Now you will be asked whether the light is visible or hidden for the BLUE person.\n\n',...
    'In this block just IGNORE the GREEN person.\n\n',...
    'You will hear a high pitch beep if you are correct, and a low beep if you are incorrect.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should use your RIGHT HAND to respond.\n\n',...
    'Report VISIBLE by pressing J.\n\n',...
    'Report HIDDEN by pressing K.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should respond as quickly as you can once you see the light turn on.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

old_stims = {
'20_B_F.png'
'20_B_B.png'
'160_B_B.png'
'160_B_F.png'
'340_B_F.png'
'340_B_B.png'};

stims = {
'fm1_li1.png'
'fm1_li3.png'
'fm2_li4.png'
'fm2_li2.png'
'fm4_li4.png'
'fm4_li2.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    tempTime = GetSecs;
    pressed = false;
    while pressed == false
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_B_'),'F.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_B_'),'B.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
end

%% practice response limit for BLUE person

Screen('TextSize',w, 30);

text = [
    'Now we will practice the task with a time limit for your responses.\n\n'...
    'You must respond as quickly as possible, or you will be presented with a warning.\n\n',...
    'In this block, again just report whether the light is visible or hidden for the BLUE person.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report VISIBLE by pressing J.\n\n',...
    'Report HIDDEN by pressing K.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;
old_stims = {

'160_B_B.png'
'160_B_F.png'
'340_B_F.png'
'340_B_B.png'
'20_B_F.png'
'20_B_B.png'};

stims = {

'fm2_li4.png'
'fm2_li2.png'
'fm4_li4.png'
'fm4_li2.png'
'fm1_li1.png'
'fm1_li3.png'};


blank_stims = {

'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'
'fm1_blank.png'
'fm1_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    pressed = false;
    while GetSecs - stim_time < responseLimit        
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_B_'),'F.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_B_'),'B.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
     if pressed == false
        currTime = stim_time + responseLimit;
        disp('Too Slow!')
        Screen('TextSize',w, 50);

        Screen('Flip', w,currTime-params.halfFrame);
        DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);
        currTime = currTime + tooSlowWarning;
        WaitSecs(tooSlowWarning);

    end

end

%% practice response limit for GREEN person

Screen('TextSize',w, 30);

text = [
    'Now, just report whether the light is visible or hidden for the GREEN person.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report VISIBLE by pressing J.\n\n',...
    'Report HIDDEN by pressing K.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;
old_stims = {
'200_G_F.png'
'200_G_B.png'
'340_G_F.png'
'340_G_B.png'
'160_G_F.png'
'160_G_B.png'};

stims = {
'fm1_li3.png'
'fm1_li1.png'
'fm2_li4.png'
'fm2_li2.png'
'fm4_li2.png'
'fm4_li4.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm4_blank.png'
'fm4_blank.png'};

currTime = GetSecs;
Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.25;
    
for i = 1:6
    Screen('TextSize',w, 24);
    if any(ismember(i,[3,5]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    

    pressed = false;
    while GetSecs - stim_time < responseLimit        
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp(extractAfter(old_stim_name,'_G_'),'F.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')
                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'k')
                if strcmp(extractAfter(old_stim_name,'_G_'),'B.png')
                     sound(correct_tone,correct_freq)
                     disp('correct')

                else
                     sound(incorrect_tone,incorrect_freq)
                     disp('incorrect')

                end
                currTime = currTime+ RT + 0.3;
                WaitSecs(0.3);
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
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
     if pressed == false
        currTime = stim_time + responseLimit;
        disp('Too Slow!')
        Screen('TextSize',w, 50);

        Screen('Flip', w,currTime-params.halfFrame);
        DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);
        currTime = currTime + tooSlowWarning;
        WaitSecs(tooSlowWarning);

    end

end

%% Practice with auditory cue
old_stims = {
'200_G_F.png'
'20_B_F.png'
'200_G_B.png'
'20_B_B.png'

'160_B_F.png'
'340_G_B.png'
'340_G_F.png'
'160_B_B.png'

'340_B_B.png'
'340_B_F.png'
'160_G_F.png'
'160_G_B.png'};

stims = {
'fm1_li3.png'
'fm1_li1.png'
'fm1_li1.png'
'fm1_li3.png'

'fm2_li2.png'
'fm2_li2.png'
'fm2_li4.png'
'fm2_li4.png'

'fm4_li2.png'
'fm4_li4.png'
'fm4_li2.png'
'fm4_li4.png'};

blank_stims = {
'fm1_blank.png'
'fm1_blank.png'
'fm1_blank.png'
'fm1_blank.png'

'fm2_blank.png'
'fm2_blank.png'
'fm2_blank.png'
'fm2_blank.png'

'fm4_blank.png'
'fm4_blank.png'
'fm4_blank.png'
'fm4_blank.png'

};


Screen('TextSize',w, 30);

text = [
    'Now, before you see each image, you will hear the word "BLUE" or "GREEN".\n\n',...
    'This will tell you whether to respond based on the blue or green persons perspective.\n\n',...
    'You should use your RIGHT HAND to respond\n\n',...
    'Report VISIBLE by pressing J.\n\n',...
    'Report HIDDEN by pressing K.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;

Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
Screen('Flip', w,currTime - params.halfFrame);
currTime = currTime + 0.75;
% WaitSecs(0.75);

for i = 1:12
    
    Screen('TextSize',w, 24);
    if any(ismember(i,[5,9]))
       DrawFormattedText(w, 'CHANGING AVATAR POSITIONS - PLEASE WAIT.','center', 'center', [255 255 255]);
       Screen('Flip', w,currTime-params.halfFrame);
       currTime = currTime + 2;
    end
    
    blank_stim_name = fullfile('stims','final',blank_stims{i});
    blank_stim = imread(blank_stim_name);
    blank_stim = im2uint8(blank_stim);
    blank_stim = Screen('MakeTexture', w, blank_stim, [], [], []);

    
    stim_name = fullfile('stims','final',stims{i});
    stim = imread(stim_name);
    stim = im2uint8(stim);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    
    old_stim_name = old_stims{i};
    disp(old_stim_name)
    
    
    Screen('DrawTexture', w, blank_stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    currTime = currTime + 1.5;
    WaitSecs(0.75);
    
    
    if contains(old_stim_name,'_B_')
       sound(blue_tone,blue_freq)
       colour = 'blue';
    else
       sound(green_tone,green_freq)
       colour = 'green';
    end
    disp(colour)
    WaitSecs(0.75);
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    
    
    pressed = false;
    while GetSecs - stim_time < 10
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'j') %if responded with left key
                if strcmp('blue', colour)
                    if strcmp(extractAfter(old_stim_name,'_B_'),'F.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                else
                    if strcmp(extractAfter(old_stim_name,'_G_'),'F.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                end
            elseif strcmp(KbName(response),'k')
                if strcmp('blue', colour)
                    if strcmp(extractAfter(old_stim_name,'_B_'),'B.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                else
                    if strcmp(extractAfter(old_stim_name,'_G_'),'B.png')
                         sound(correct_tone,correct_freq)
                         disp('correct')
                    else
                         sound(incorrect_tone,incorrect_freq)
                         disp('incorrect')
                    end
                    currTime = currTime + RT + 0.3;
                    WaitSecs(0.3);
                    break
                end
            elseif strcmp(KbName(response),'ESCAPE') % Press escape to close all
                    Screen('CloseAll');
            else
                currTime = currTime + RT;
                Screen('TextSize',w, 50);
                Screen('Flip', w,currTime-params.halfFrame);
                DrawFormattedText(w, 'WRONG KEY!','center', 'center', [255 0 0]);
                Screen('Flip', w,currTime-params.halfFrame);
                currTime = currTime + tooSlowWarning;
                WaitSecs(tooSlowWarning);
                break
            end
        end
    end
    if pressed == false
        currTime = stim_time + responseLimit;
        disp('Too Slow!')
        Screen('TextSize',w, 50);

        Screen('Flip', w,currTime-params.halfFrame);
        DrawFormattedText(w, 'TOO SLOW!','center', 'center', [255 0 0]);
        Screen('Flip', w,currTime-params.halfFrame);
        currTime = currTime + tooSlowWarning;
        WaitSecs(tooSlowWarning);

    end

end
sca;