function EEG = pretoset(directo, foldname, samplerate, readchan, save)
%TOSET 이 함수의 요약 설명 위치
%   자세한 설명 위치
list = dir([directo,foldname,'\*.csv']);
N = size(list,1);
chanlocs = pop_chanedit(readchan);

for i=1:N
    fn =[directo,foldname, '\', list(i).name];
    df = csvread(fn ,1,0);
    [filepath,name,ext] = fileparts(fn);
    
    data = transpose(df);
    standTime = data(1,:);
    standData = data(2:7,:); 
    
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
    EEG = pop_resample(EEG, 250);
    EEG = eeg_checkset(EEG);
%     EEG = pop_clean_rawdata(EEG);
    EEG = clean_artifacts(EEG, 'channelcriterion', 0.80, 'linenoisecriterion', 4, 'flatlinecriterion', 5,'burst_crit', 10 ); %'burst_crit', 10
    EEG = eeg_checkset(EEG);
    EEG = pop_runica(EEG, 'icatype', 'runica');
    EEG = eeg_checkset(EEG);
    EEG = iclabel(EEG);
%     sprintf("classifi")
    
    [rows, cols] = size(EEG.etc.ic_classification.ICLabel.classifications); %3(eye),4(heart) 제거
    for i = rows: 1
        if (EEG.etc.ic_classification.ICLabel.classifications(i,3) > 0.8)
            and (EEG.etc.ic_classification.ICLabel.classifications(i,4) > 0.8)
            and (EEG.etc.ic_classification.ICLabel.classifications(i,2) > 0.8)
            and (EEG.etc.ic_classification.ICLabel.classifications(i,5) > 0.8)
            and (EEG.etc.ic_classification.ICLabel.classifications(i,6) > 0.8)
            and (EEG.etc.ic_classification.ICLabel.classifications(i,7) > 0.8)
            EEG = pop_subcomp(EEG, i);
        end
    end
    EEG = eeg_checkset(EEG);
    
    mkdir(['setfile/', foldname]);
    pop_artmwppth();
    if save
        eegsave(EEG, name,['C:\Users\cgna\Documents\GitHub\eeg_preprocessing\setfile\', foldname])
    end
end

function eegsave(EEG, name, location)
    pop_saveset( EEG, name, location); %'C:\Users\user\Desktop\연구\matlab\eeg_preprocessing\setfile'
end

end