subj = 'sub1';
block = 1;
prefix = fullfile('results',subj,'MEG');
load(fullfile(prefix,strcat('results_block_',string(block),'.mat')));

correct = results.correct;
RTs = results.RTs;
correctRTs = RTs(correct == 1);

smallRTs = correctRTs(trials(2,:) == 1);
bigRTs = correctRTs(trials(2,:) == 2);

bar([mean(smallRTs),mean(bigRTs)])