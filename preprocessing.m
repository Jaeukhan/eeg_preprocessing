addpath('function');
save = true;
lpf = 1;
samplerate = 500;
foldname = '12sb';
readchan = readlocs('C:\Users\user\Documents\GitHub\eeg_preprocessing\Standard-10-10-Cap5.ced');

toset('C:\Users\user\Documents\GitHub\eeg_preprocessing\Waveresults\', foldname,samplerate, readchan, save);
% EEG = pretoset('C:\Users\user\Documents\GitHub\eeg_preprocessing\Waveresults\', foldname,samplerate, readchan, save);