foldname = 'nogain';
directo = ['setfile/',foldname,'/'];
list = dir(strcat(directo,'*.set'));
N = size(list,1);
resampling = 250;
seconds = 5;

lastname = {'delta', 'theta', 'alpha', 'beta'};

if ~exist(['results/', foldname],'dir')
    mkdir(['results/', foldname]);
end
for i =1:N
    fn =strcat(directo, list(i).name);
    EEG = load('-mat',fn);
    [filepath,name,ext] = fileparts(fn);
    data = EEG.data;
    [rows, columns] = size(data);
    changecolumn =  columns - rem(columns, resampling * seconds);
    
for j = 1:rows %row는 channel
        ds = [];
        ths = [];
        as = [];
        bs = [];
        [spectra,freqs] = spectopo(EEG.data(j,:), 0, EEG.srate);
        xlim([0,80])
        saveas(gcf, [num2str(i),'plot', num2str(j),'.png'])
        % delta=1-4, theta=4-8, alpha=8-13, beta=13-30, gamma=30-80
        deltaIdx = find(freqs>1 & freqs<4);
        thetaIdx = find(freqs>4 & freqs<8);
        alphaIdx = find(freqs>8 & freqs<13);
        betaIdx  = find(freqs>13 & freqs<30);
        gammaIdx = find(freqs>30 & freqs<50);

        % compute absolute power
        deltaPower = mean(10.^(spectra(deltaIdx)/10));
        thetaPower = mean(10.^(spectra(thetaIdx)/10));
        alphaPower = mean(10.^(spectra(alphaIdx)/10));
        betaPower  = mean(10.^(spectra(betaIdx)/10));

        ds = [ds, deltaPower];
        ths = [ths, thetaPower];
        as = [as, alphaPower];
        bs = [bs, betaPower];
        all = [];
        all = [all, ds, ths, as, bs];
        all = all * 10^6;
        poall = reshape(all,4,[]);
%         [porow, pocol] = size(poall);
        poall = num2cell(poall);
        T = cell2table(poall,'RowNames', lastname); %VariableNames
%         writetable(T, 'text.txt', 'WriteRowNames', true);
        s = {EEG.chanlocs.labels};
        st = strcat('results/', foldname,'/' , name ,  s{j} , '.csv');
        clf;
%         writetable(T, st);
    end
 
end
%     for j = 1:rows %row는 channel
%         ds = [];
%         ths = [];
%         as = [];
%         bs = [];
%         for k = 1:resampling * seconds:changecolumn
%             [spectra,freqs] = spectopo(EEG.data(j,k:k+seconds*resampling), 0, EEG.srate);
% 
%             % delta=1-4, theta=4-8, alpha=8-13, beta=13-30, gamma=30-80
%             deltaIdx = find(freqs>1 & freqs<4);
%             thetaIdx = find(freqs>4 & freqs<8);
%             alphaIdx = find(freqs>8 & freqs<13);
%             betaIdx  = find(freqs>13 & freqs<30);
%             gammaIdx = find(freqs>30 & freqs<80);
% 
%             % compute absolute power
%             deltaPower = mean(10.^(spectra(deltaIdx)/10));
%             thetaPower = mean(10.^(spectra(thetaIdx)/10));
%             alphaPower = mean(10.^(spectra(alphaIdx)/10));
%             betaPower  = mean(10.^(spectra(betaIdx)/10));
% 
%             ds = [ds, deltaPower];
%             ths = [ths, thetaPower];
%             as = [as, alphaPower];
%             bs = [bs, betaPower];
%         end
%         all = [];
%         all = [all, ds, ths, as, bs];
%         poall = reshape(all,4,[]);
% %         [porow, pocol] = size(poall);
%         poall = num2cell(poall);
%         T = cell2table(poall,'RowNames', lastname); %VariableNames
% %         writetable(T, 'text.txt', 'WriteRowNames', true);
%         s = {EEG.chanlocs.labels};
%         st = strcat('results/' , name ,  s{j} , '.csv');
%         writetable(T, st, 'WriteRowNames', true);
%     end
%  
% end
