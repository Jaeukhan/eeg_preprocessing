function csvplotting(foldname)
data = csvread(['D:\J.U. Han\eeg_preprocessing\Waveresults', foldname] ,1,1);
data = transpose(data);
eegplot(data)
end