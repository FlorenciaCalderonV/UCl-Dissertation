function stimulus = stimNoise(stim_path,vis,avgMag)
% Function to combine average magnitude matrix with specific stim phase
% matrix and a certain visibility
%
% Requires stim path, level of noise, average magnitude matrix

global params
warning off;

d = 1 - vis; %noise level = 1-visibility;

file = char(stim_path);
pic = imread(file);
pic = imresize(pic, [params.stimSizeInPix params.stimSizeInPix]);

if length(size(pic)) == 3 %if imported as color image
    pic = pic(:,:,2); %select single channel (green in this case) to process as greyscale
end
% pic90 = imrotate(pic,90);
% picFinal = double(pic90);
picFinal = double(pic);
picFFT = fftshift(fft2(picFinal));
picP = angle(picFFT);

noiseMatrix = rand(size(avgMag));
%disp(size(noiseMatrix))
noiseFFT = fftshift(fft2(noiseMatrix));
noiseP = angle(noiseFFT);


% x = stimIndex;
% for x = 1:length(stimFiles)

% stimPhaseToShow = (d*noiseP) + ((1-d)*allpicsP(:,:,x));    % Linear combination of stim and noise phase matrices for each stimulus in block array
stimPhaseToShow = (d*noiseP) + ((1-d)*picP);
% Combine with average mag to form FFT of final image
stimToShow = avgMag.*(cos(stimPhaseToShow) + i*sin(stimPhaseToShow));
% Invert to display
% stimFinal = uint8(ifft2(stimToShow));
stimFinal = ifft2(stimToShow);

%     figure; imshow(stimFinal);
% end
stimulus = uint8(stimFinal(7:end-7+1,7:end-7+1));
end