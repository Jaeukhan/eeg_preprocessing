addpath('function');
save = true;
lpf = 1;
samplerate = 500;
foldname = 'nogain';
readchan = readlocs('C:\Users\cgna\Documents\GitHub\ju\eeg_preprocessing\Standard-10-10-Cap6.ced');

toset('C:\Users\cgna\Documents\GitHub\ju\eeg_preprocessing\Waveresults\rawdata\', foldname,samplerate, readchan, save);
% EEG = pretoset('C:\Users\user\Desktop\연구\matlab\eeg_preprocessing\Waveresults\1216raw\1215su\',samplerate, readchan, save);