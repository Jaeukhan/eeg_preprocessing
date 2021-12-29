function setplotting(foldname, inputArg2)
%PLOTTING 이 함수의 요약 설명 위치
%   자세한 설명 위치
set = load('-mat', ['D:\J.U. Han\eeg_preprocessing\setfile', foldname]);
eegplot(set.data)
end

function csvplotting(foldname)
data = csvread(['D:\J.U. Han\eeg_preprocessing\Waveresults\1', foldname] ,1,0);
eegplot(data)
end
