function [ startTime ] = waitForTrigger()
% Adaptation of Matan's code for fMRI trigger

    global w
    global params
    global scanner
    
    % MRI wait for 6th volume to start
    if scanner == 1
        excludeVolumes = 5; % slicesPerVolume = 48;
        scannerTrigger = KbName('5%');

        %initialize
        num_five = 0; % how many triggers did I get from the scanner?
        while num_five < excludeVolumes % * slicesPerVolume

            DrawFormattedText(w, sprintf('We are just about to begin block %d/%d.', ...
                params.block_num, params.Nruns), 'center', 'center', [255 255 255])
            vbl = Screen('Flip', w);

            [keyIsDown, secs, keyCode] = KbCheck;

            if keyIsDown
                if keyCode(scannerTrigger)
                    num_five = num_five + 1;
                elseif keyCode(KbName('SPACE')) % Press space to move on manually
                    num_five = inf;
                elseif keyCode(KbName('ESCAPE')) % Press escape to close all
                    Screen('CloseAll');
                    clear;
                    return
                end
            end
        end

    % MEG moves on when we press space
    else
        while(1)
            DrawFormattedText(w, sprintf('We are just about to begin block %d/%d. \n\n Experimenter, please press space.', ...
                params.block_num, params.Nruns),'center', 'center', [255 255 255]);
            
            vbl = Screen('Flip', w);      
            
            [keyIsDown, secs, keyCode] = KbCheck;
            disp('keyCode')
            if keyIsDown
                if keyCode(KbName('SPACE'))
                    break
                elseif keyCode(KbName('ESCAPE'))
                    Screen('CloseAll');
                    clear;
                    return
                end
            end
        end
    end
    
    startTime = secs;
end