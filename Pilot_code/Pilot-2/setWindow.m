function [ w, rect, offW ] = setWindow( debug )
%open psychtoolbox and set up screen for experiment

global scanner
if debug
    PsychDebugWindowConfiguration() 
end

% Run tests in experiment, skip during debugging
Screen('Preference','SkipSyncTests', 1)
screens = Screen('Screens');


%screenNumber = max(screens);

screenNumber = 0;

%screenNumber = 1;
doublebuffer = 1;

% Open screen with grey background
[w, rect] = Screen('OpenWindow', screenNumber,...
    [255/2,255/2,255/2],[], 32, doublebuffer+1);

% Set useful paramaters
KbName('UnifyKeyNames');
AssertOpenGL;
PsychVideoDelayLoop('SetAbortKeys', KbName('Escape'));
HideCursor();
Priority(MaxPriority(w));
Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

%The fMRI button box does not work well with KbCheck. I use KbQueue
%instead here, to get precise timings and be sensitive to all presses.
% KbQueueCreate;
% KbQueueStart;

%audio
%audio_wrong = PsychPortAudio('Open',[],[],[],250);
%audio_right = PsychPortAudio('Open',[],[],[],1500);


end

