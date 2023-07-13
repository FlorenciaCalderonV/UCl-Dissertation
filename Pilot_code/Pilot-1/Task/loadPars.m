function params = loadPars(rect, subj, block_num)
    % Load parameters that stay the same for each block
    % 18/01/22 BOB

    global w
    global setTrigger
    global environment
    

    % Define useful parameters
    params.ifi = 1/30;                  % Vertical refresh rate 
    params.keys = {'1!', '2@', '3#', '4$','6^','7&'};
  
    % Define useful window positions
    [params.center(1), params.center(2)] = RectCenter(rect);
    params.rect = rect;

    % Save subject + block number
    params.name = subj;
    params.block_num = block_num;

    
% 
%     % Trigger info for MEG
if setTrigger
     params.trigger.port = 888;              % Parallel port
     params.trigger.cueOnset = 1;          % Trigger numbers
     params.trigger.stimOnset = 2;           % "
     params.trigger.responseOnset = 3;       % "
     params.trigger.null = 0;                % Set trigger back to 0
     params.trigger.nullTime = 50;           % Length of trigger = 50ms

     params.trigger.object = io64;
     status = io64(params.trigger.object);
     %params.trigger.scanport = 888; %hex2dec('3FF8'); %%adress of LPT3
     params.trigger.scanport = hex2dec('3FF8');
    
    % Square for photodiode
    baseRect = [0 0 60 60];
    [ ~, screenYpixels] = Screen('WindowSize', w);
    params.diodeRect = CenterRectOnPoint(baseRect, 10, screenYpixels);

end
    % MEG settings 
    switch environment
        case 1 % Instructions
            [frameHz, params.stimSizeInPix] = get_monitor_info('behavioural');
            params.Ntrials = 32;
            params.resultsDir = fullfile('results', sprintf('sub%s', subj), 'MEG');
            params.Nruns = 12;
        case 2 %Main
            [frameHz, params.stimSizeInPix] = get_monitor_info('behavioural');
            params.Ntrials = 32;
            params.resultsDir = fullfile('results', sprintf('sub%s', subj), 'MEG');
            params.Nruns = 12;
     end

    % Make results directory
    if ~exist(params.resultsDir, 'dir')
        mkdir(params.resultsDir)
    end
    
    
    params.halfFrame = 0.5/frameHz;          % Request presentation half a frame before needed
    
end