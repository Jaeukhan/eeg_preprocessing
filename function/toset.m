function toset(directo, foldname, samplerate, readchan, save)
%TOSET 이 함수의 요약 설명 위치
%   자세한 설명 위치
list = dir([directo,foldname,'\*.csv']);
N = size(list,1);
chanlocs = pop_chanedit(readchan);

for i=1:N
    fn =[directo, foldname,'\', list(i).name];
    df = csvread(fn ,1,0);
    [filepath,name,ext] = fileparts(fn);
    
    data = transpose(df);
    standTime = data(1,:);
    standData = data(2:6,:);
    
    EEG = pop_importdata('data', standData);
    EEG.times = standTime;
    EEG.setname = name;
    EEG.srate = samplerate;
    EEG.epoch = 1;
    EEG = eeg_checkset(EEG);
    EEG.chanlocs = chanlocs;
    EEG = eeg_checkset(EEG);
    EEG = pop_eegfiltnew(EEG,'locutoff',0.5);
    EEG = eeg_checkset(EEG);
    EEG = pop_resample(EEG, 250)
    EEG = eeg_checkset(EEG);
    if ~exist(['setfile/', foldname],'dir')
        mkdir(['setfile/', foldname]);
    end
    eegsave(EEG, strcat('ori',name),['C:\Users\user\Documents\GitHub\eeg_preprocessing\setfile\', foldname])
end

end


function eegsave(EEG, name, location)
    pop_saveset( EEG, name, location); %'C:\Users\user\Desktop\연구\matlab\eeg_preprocessing\setfile'
end
