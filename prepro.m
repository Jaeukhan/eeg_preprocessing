addpath('function');
save = true;
lpf = 1;
samplerate = 500;
foldname = 'kh';
readchan = readlocs('C:\Users\user\Desktop\연구\matlab\eeg_preprocessing\Standard-10-10-Cap6.ced');

toset('C:\Users\user\Desktop\연구\matlab\eeg_preprocessing\Waveresults\rawdata\', foldname,samplerate, readchan, save);
% EEG = pretoset('C:\Users\user\Desktop\연구\matlab\eeg_preprocessing\Waveresults\1216raw\1215su\',samplerate, readchan, save);