function [frameHz, stimSizeInPix, calibrationFile] = get_monitor_info(location)

% [frameHz, pixPerDeg, calibrationFile] = getMonitorInfo(location)
%
% Arguments:
%   location:   'debug'         = Benjy's Laptop
%               'behavioural'   = Behavioural lab (same as benjy monitor at
%               FIL)
%               'mri'           = Quattro scanner
%               'MEG'           = MEG at FIL
%               'random'        = manually put in screen info 
% By ND, JAN 2020

stimSizeInDegree = 5.5;%atan(7.3/2/60)*180/pi*2;

    
switch location
    case 'debug'       
        screenSize       = [28.6 18]; % width by height in cm
        screenResolution = [1920 1200];
        screenDistance   = 60;       
        frameHz          = 60;               % frameHz = Screen('FrameRate', scrnum)
        calibrationFile = [];
        
    case 'behavioural'        
        screenSize       = [51.84 32.4]; % width by height in cm
        screenResolution = [1920 1200];
        screenDistance   = 60;        
        frameHz          = 60;               % frameHz = Screen('FrameRate', scrnum)
        calibrationFile  = [];
        
    case 'mri'
        screenSize       = [51.84 32.4]; % width by height in cm
        screenResolution = [1920 1200];
        screenDistance   = 60;        
        frameHz          = 60;               % frameHz = Screen('FrameRate', scrnum)
        calibrationFile  = [];
     
    case 'meg'
        screenSize       = [40 29.5]; % width by height in cm
        screenResolution = [1024 768];
        screenDistance   = 52; 
        frameHz          = 60;               % frameHz = Screen('FrameRate', scrnum)
        calibrationFile = [];
       
        
    case 'random'
        % Any random computer
        screenWidth = input('What is the screen width in centimeters?');
        screenHeight = input('What is the screen height in centimeters?');
        screenDistance = input('What is the distance to the screen in centimeters?');
        screenNumber = input('What is the screen number you want to use? Default is 0');
        [screenResolution(1), screenResolution(2)] = Screen('WindowSize', screenNumber);
        visualField_horizontal = atan(screenWidth/2/distanceToScreen)*180/pi*2;    % in degrees
        horizontal_pixPerDeg = screenResolution(1)/visualField_horizontal;         % in degrees
        visualField_vertical = atan(screenHeight/2/distanceToScreen)*180/pi*2;     % in degrees
        vertical_pixPerDeg = screenResolution(2)/visualField_vertical;             % in degrees
        
        frameHz = Screen('FrameRate', screenNumber);
        calibrationFile = [];
        
    otherwise
        error('Invalid location entered');
end


pixPerDegree     = ((screenResolution(1)/(atan(screenSize(1)/2/screenDistance)*180/pi*2)) + ...
    (screenResolution(2)/(atan(screenSize(2)/2/screenDistance)*180/pi*2)))/2;
disp(pixPerDegree)
stimSizeInPix    = round(stimSizeInDegree*pixPerDegree);



