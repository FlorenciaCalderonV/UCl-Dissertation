function [ results ] = showInstructions()


global w
global params

responseLimit = 1.5;
tooSlowWarning = 1;
currTime = GetSecs;

%feedback tones
[correct_tone, correct_freq] = psychwavread('stims/correct_tone.wav');
cor_wavedata = correct_tone';


[incorrect_tone, incorrect_freq] = psychwavread('stims/incorrect_tone.wav');
incor_wavedata = incorrect_tone';
nrchannels = size(incor_wavedata,1); % Number of rows == number of channels.


%audio
audio_incorrect = PsychPortAudio('Open', [], [], 0, incorrect_freq, nrchannels);
PsychPortAudio('FillBuffer', audio_incorrect, incor_wavedata);

audio_correct = PsychPortAudio('Open', [], [], 0, correct_freq, nrchannels);
PsychPortAudio('FillBuffer', audio_correct, cor_wavedata);
PsychPortAudio('Start', audio_correct, 1,currTime,[],currTime+0.01 ,[]); %this here because first tone never plays (??), so put dummy tone here that we're not interested in

Screen('TextSize',w, 28);
text = ['Thank you for participating in our study!\n\n', ...
         'This study is made up of two different - but very similar - tasks.\n\n',...
        'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);
KbStrokeWait;

%% Explain task

text = ['First, we will show you how to perform the Left or Right Task.\n\n',...
    'In this task, you will see an image of a man sat at a round table.\n\n'...
    'In each image, a light will be illuminated somewhere on the table.\n\n',...
    'Your job will be to decide, for each image, whether the light is on the left or the right of the man.\n\n'...
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
        stimulus_path = fullfile('stims', 'rot60drwhoL.jpg'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        caption = 'Light on the LEFT of the man is on';
    elseif i == 2
        stimulus_path = fullfile('stims', 'rot200drwhoR.jpg'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        caption = 'Light on the RIGHT of the man is on';
    elseif i == 3
        stimulus_path = fullfile('stims', 'rot300drwhoL.jpg'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        caption = 'Light on the LEFT of the man is on';
    elseif i == 4
        stimulus_path = fullfile('stims', 'rot160drwhoR.jpg'); %hard coded stim image will need to change when make real stims
        stimulus = imread(stimulus_path);
        caption = 'Light on the RIGHT of the man is on';
     end
    
   stimulus = Screen('MakeTexture', w, stimulus, [], [], []); 
    DrawFormattedText(w, sprintf(caption),'center',150, [255 255 255]);
        Screen('TextSize',w, 20);

    DrawFormattedText(w, 'Press any button to continue','center',1050, [255 255 255]);

    Screen('DrawTexture', w, stimulus);
    Screen('Flip', w);
%     WaitSecs(0.5)
    KbStrokeWait;
end

%% Practice with no response limit
Screen('TextSize',w,30);

text = [
    'First we will practice an easy version of the task.\n\n'...
    'In this practice version, there will be no time limit for you to respond.\n\n',...
    'You will see 10 images after one another.\n\n',...
    'You will be asked whether the light is on the left or right of the man.\n\n',...
    'You will hear a high pitch beep if you are correct, and a low beep if you are incorrect.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should use your LEFT HAND to respond.\n\n',...
    'Report LEFT by pressing 1.\n\n',...
    'Report RIGHT by pressing 2.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should respond as quickly as you can once you see the image.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

stims = {'rot60drwhoL.jpg'
'rot60drwhoR.jpg'
'rot160drwhoL.jpg'
'rot160drwhoR.jpg'
'rot200drwhoL.jpg'
'rot200drwhoR.jpg'
'rot300drwhoL.jpg'
'rot300drwhoR.jpg'};

for i = 1:10
    
    stim_name = fullfile('stims',stims{randi(length(stims))});
    stim = imread(stim_name);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    currTime = GetSecs;
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    Screen('Flip', w,currTime - params.halfFrame);
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
            if strcmp(KbName(response),'1!') %if responded with left key
                if strcmp(extractAfter(stim_name,'drwho'),'L.jpg')
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')
                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'2@')
                if strcmp(extractAfter(stim_name,'drwho'),'R.jpg')

                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')

                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
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

%% practice response limit

Screen('TextSize',w, 30);

text = [
    'Now we will practice the task with a time limit for your responses.\n\n'...
    'You must respond as quickly as possible, or you will be presented with a warning.\n\n',...
    'You should use your LEFT HAND to respond\n\n',...
    'Report LEFT by pressing 1.\n\n',...
    'Report RIGHT by pressing 2.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;

for i = 1:10
    
    stim_name = fullfile('stims',stims{randi(length(stims))});
    stim = imread(stim_name);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    currTime = GetSecs;
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    Screen('Flip', w,currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    
    pressed = false;
    while GetSecs - stim_time < responseLimit
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'1!') %if responded with left key
                if strcmp(extractAfter(stim_name,'drwho'),'L.jpg')
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')
                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'2@')
                if strcmp(extractAfter(stim_name,'drwho'),'R.jpg')

                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')

                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
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

%%practice more trials
currTime = GetSecs;
Screen('TextSize',w, 30);
text = [
    'Good job! Now we will practice for a little bit longer.\n\n'...
    'Remember to respond as quickly as possible!\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;

for i = 1:20
    
    stim_name = fullfile('stims',stims{randi(length(stims))});
    stim = imread(stim_name);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    currTime = GetSecs;
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    Screen('Flip', w,currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    
    pressed = false;
    while GetSecs - stim_time < responseLimit
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'1!') %if responded with left key
                if strcmp(extractAfter(stim_name,'drwho'),'L.jpg')
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')
                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'2@')
                if strcmp(extractAfter(stim_name,'drwho'),'R.jpg')

                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')

                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
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


%% practice V/O task
Screen('TextSize',w, 30);

text = [
    'Now we will practice the second task.\n\n'...
    'In this task, the images will look similar to those in the first task, but now the lights will be visible or hidden.\n\n'...
    'you will have to report whether the light is visible to the man or not.\n\n'...
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


stims = {'rot60drwhoF.jpg'
'rot60drwhoB.jpg'
'rot160drwhoF.jpg'
'rot160drwhoB.jpg'
'rot200drwhoF.jpg'
'rot200drwhoB.jpg'
'rot300drwhoF.jpg'
'rot300drwhoB.jpg'};

for i = 1:4
    Screen('TextSize',w, 30);

     if i == 1
        stimulus_path = fullfile('stims', 'rot60drwhoF.jpg'); 
        stimulus = imread(stimulus_path);
        caption = 'Light is VISIBLE to the man';
    elseif i == 2
        stimulus_path = fullfile('stims', 'rot200drwhoB.jpg'); 
        stimulus = imread(stimulus_path);
        caption = 'Light is HIDDEN from the man';
    elseif i == 3
        stimulus_path = fullfile('stims', 'rot300drwhoF.jpg'); 
        stimulus = imread(stimulus_path);
        caption = 'Light is VISIBLE to the man';
    elseif i == 4
        stimulus_path = fullfile('stims', 'rot160drwhoB.jpg'); 
        stimulus = imread(stimulus_path);
        caption = 'Light is HIDDEN from the man';
     end
    
   stimulus = Screen('MakeTexture', w, stimulus, [], [], []); 
    DrawFormattedText(w, sprintf(caption),'center',150, [255 255 255]);
        Screen('TextSize',w, 20);

    DrawFormattedText(w, 'Press any button to continue','center',1050, [255 255 255]);

    Screen('DrawTexture', w, stimulus);
    Screen('Flip', w);
%     WaitSecs(0.5)
    KbStrokeWait;
end


%% practice v/o with response limit

Screen('TextSize',w,30);

text = [
    'First we will practice an easy version of the task.\n\n'...
    'In this practice version, there will be no time limit for you to respond.\n\n',...
    'You will see 10 images after one another.\n\n',...
    'You will be asked whether the light is visible or hidden for the man.\n\n',...
    'You will hear a high pitch beep if you are correct, and a low beep if you are incorrect.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should use your LEFT HAND to respond.\n\n',...
    'Report VISIBLE by pressing 1.\n\n',...
    'Report HIDDEN by pressing 2.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;

text = ['You should respond as quickly as you can once you see the image.\n\n',...
    'Press any key to continue.'];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w);   
[~,key,~] = KbStrokeWait;


for i = 1:10
    
    stim_name = fullfile('stims',stims{randi(length(stims))});
    stim = imread(stim_name);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    currTime = GetSecs;
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    Screen('Flip', w,currTime - params.halfFrame);
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
            if strcmp(KbName(response),'1!') %if responded with left key
                if strcmp(extractAfter(stim_name,'drwho'),'F.jpg')
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')
                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'2@')
                if strcmp(extractAfter(stim_name,'drwho'),'B.jpg')

                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')

                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
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

%% practice response limit

Screen('TextSize',w, 30);
text = [
    'Now we will practice the task with a time limit for your responses.\n\n'...
    'You must respond as quickly as possible, or you will be presented with a warning.\n\n',...
    'You should use your LEFT HAND to respond\n\n',...
    'Report VISIBLE by pressing 1.\n\n',...
    'Report HIDDEN by pressing 2.\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;

for i = 1:10
    
    stim_name = fullfile('stims',stims{randi(length(stims))});
    stim = imread(stim_name);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    currTime = GetSecs;
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    Screen('Flip', w,currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    
    pressed = false;
    while GetSecs - stim_time < responseLimit
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'1!') %if responded with left key
                if strcmp(extractAfter(stim_name,'drwho'),'F.jpg')
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')
                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'2@')
                if strcmp(extractAfter(stim_name,'drwho'),'B.jpg')

                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')

                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
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

%%practice more trials
currTime = GetSecs;
Screen('TextSize',w, 30);

text = [
    'Good job! Now we will practice for a little bit longer.\n\n'...
    'Remember to respond as quickly as possible!\n\n',...
    'Press any key to continue.'
    ];
DrawFormattedText(w, text, 'center', 'center', 255);
vbl = Screen('Flip', w,currTime);
[~,key,~] = KbStrokeWait;

currTime = GetSecs;

for i = 1:20
    
    stim_name = fullfile('stims',stims{randi(length(stims))});
    stim = imread(stim_name);
    stim = Screen('MakeTexture', w, stim, [], [], []);
    
    currTime = GetSecs;
    Screen('DrawLines', w, [0 0 -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05); -round(params.stimSizeInPix*0.05) round(params.stimSizeInPix*0.05) 0 0], round(params.stimSizeInPix*0.015), [0,0,0], params.center, 1);
    Screen('Flip', w,currTime - params.halfFrame);
    currTime = currTime + 0.75;
    
    
    Screen('DrawTexture', w, stim);
    stim_time = Screen('Flip', w, currTime - params.halfFrame);
    
    pressed = false;
    while GetSecs - stim_time < responseLimit
        [keyIsDown, secs, response] = KbCheck;
        if keyIsDown
            pressed = true;
            RT = secs - stim_time;
            if strcmp(KbName(response),'1!') %if responded with left key
                if strcmp(extractAfter(stim_name,'drwho'),'F.jpg')
                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')
                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('incorrect')
                end
                currTime = currTime + RT + 0.3;
                WaitSecs(0.3);
                break
            elseif strcmp(KbName(response),'2@')
                if strcmp(extractAfter(stim_name,'drwho'),'B.jpg')

                     PsychPortAudio('Start', audio_correct, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
                     disp('correct')

                else
                     PsychPortAudio('Start', audio_incorrect, 1,currTime+RT,[],currTime+RT+0.3 ,[]);
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

sca;