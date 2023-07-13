%% Housekeeping
clear all

clearvars
close all
pl=1;
addpath OPM-master/

cd  '/Users/florenciacalderon/Desktop/Mat ab filed trip/Noise_test/sub-001/ses-001/meg'% do not need to call this agan cuz we allready in the same folder
S= []; % empty sruct (a cfg)
S.data= 'ds_sub-001_ses-001_task-baseline_room_empty_run-001_meg.bin'; %where the data is
D1 = spm_opm_create(S); % this is the meeg object containing the data from the file

Yinds  = selectchannels(D1,'MEG');% all the channels in the object within the meg fle
S=[]; %new cfg
S.D=D1; % add data to cfg
S.plot=1; % type of plot
S.channels=chanlabels(D1,Yinds); %the channels i wanna plot
S.triallength=3000; % length of trial
[p,f] = spm_opm_psd(S); % power spectral density
%   f               - frequencies psd is sampled at

ylim([1,1e4])
xlim([0 100])
title('Baseline')



S= [];
S.data= 'ds_sub-001_ses-001_task-table_off_run-001_meg.bin';
D1 = spm_opm_create(S);

Yinds  = selectchannels(D1,'MEG');
S=[];
S.D=D1;
S.plot=1;
S.channels=chanlabels(D1,Yinds);
S.triallength=3000;
[p,f] = spm_opm_psd(S);
ylim([1,1e4])
xlim([0 100])
title('Table in room, lights off')

S= [];
S.data= 'ds_sub-001_ses-001_task-table_on_run-001_meg.bin';
D1 = spm_opm_create(S);

Yinds  = selectchannels(D1,'MEG');
S=[];
S.D=D1;
S.plot=1;
S.channels=chanlabels(D1,Yinds);
S.triallength=3000;
[p,f] = spm_opm_psd(S);
ylim([1,1e4])
xlim([0 100])
title('Table in room, lights on')