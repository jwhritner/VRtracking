%% Effect sizes and p values for tracking features 

% load the data you want
load('exp1sparseData.mat')
data = exp1sparseData; 
bsData = exp1sparseData.bsData

%% Compute the p-value for the difference distributions
% Taken in the direction of the effect 

% p values for X-Z comparisons 
diffDistPeaks = bsData.bootXpeak - bsData.bootZpeak;
diffDistPeaks = permute(diffDistPeaks,[2 1]); 
pValPeaksXZ = sum(diffDistPeaks <= 0)./10000; % peaks are the other direction because of the effect (shift towards lower correlation for depth)

diffDistLags = bsData.bootXlags - bsData.bootZlags;
diffDistLags = permute(diffDistLags,[2 1]); 
pValLagsXZ = sum(diffDistLags >= 0)./10000;

diffDistWidths = bsData.bootXwidth - bsData.bootZwidth;
diffDistWidths = permute(diffDistWidths,[2 1]); 
pValWidthsXZ = sum(diffDistWidths >= 0)./10000;

pValsXZ = [pValPeaksXZ;pValLagsXZ;pValWidthsXZ] % peaks, lags, widths x 4 conds 

% p values for Y-Z comparisons 
diffDistPeaks = bsData.bootYpeak - bsData.bootZpeak;
diffDistPeaks = permute(diffDistPeaks,[2 1]); 
pValPeaksYZ = sum(diffDistPeaks <= 0)./10000; % peaks are the other direction because of the effect (shift towards lower correlation for depth)

diffDistLags = bsData.bootYlags - bsData.bootZlags;
diffDistLags = permute(diffDistLags,[2 1]); 
pValLagsYZ = sum(diffDistLags >= 0)./10000;

diffDistWidths = bsData.bootYwidth - bsData.bootZwidth;
diffDistWidths = permute(diffDistWidths,[2 1]); 
pValWidthsYZ = sum(diffDistWidths >= 0)./10000;

pValsYZ = [pValPeaksYZ;pValLagsYZ;pValWidthsYZ] % peaks, lags, widths x 4 conds 

% Comparing to average X/Y 
frontoPeaks = (bsData.bootXpeak + bsData.bootYpeak)./2; 
diffDistPeaks = frontoPeaks - bsData.bootZpeak;
diffDistPeaks = permute(diffDistPeaks,[2 1]); 
pValPeaksXYZ = sum(diffDistPeaks <= 0)./10000;

frontoLags = (bsData.bootXlags + bsData.bootYlags)./2; 
diffDistLags = frontoLags - bsData.bootZlags;
diffDistLags = permute(diffDistLags,[2 1]); 
pValLagsXYZ = sum(diffDistLags >= 0)./10000;

frontoWidths = (bsData.bootXwidth + bsData.bootYwidth)./2; 
diffDistWidths = frontoWidths - bsData.bootZwidth;
diffDistWidths = permute(diffDistWidths,[2 1]); 
pValWidthsXYZ = sum(diffDistWidths >= 0)./10000;

pValsXYZ = [pValPeaksXYZ;pValLagsXYZ;pValWidthsXYZ] % peaks, lags, widths x 4 conds 

%% Effect sizes 

% effect XZ
for i = 1:length(data.theRows)
    effect_sizeXZ(i,1) = abs(mean(data.allXpeak(:,i,:))-mean(data.allZpeak(:,i,:)))./sqrt(var(data.allXpeak(:,i,:))+var(data.allZpeak(:,i,:)));
    effect_sizeXZ(i,2) = abs(mean(data.allXlagAtPeak(:,i,:))-mean(data.allZlagAtPeak(:,i,:)))./sqrt(var(data.allXlagAtPeak(:,i,:))+var(data.allZlagAtPeak(:,i,:)));
    effect_sizeXZ(i,3) = abs(mean(data.allXwidth(i,:))-nanmean(data.allZwidth(i,:)))./sqrt(var(data.allXwidth(i,:))+nanvar(data.allZwidth(i,:)));

end
effect_sizeXZ = effect_sizeXZ'

% effect YZ
for i = 1:length(data.theRows)
    effect_sizeYZ(i,1) = abs(mean(data.allYpeak(:,i,:))-mean(data.allZpeak(:,i,:)))./sqrt(var(data.allYpeak(:,i,:))+var(data.allZpeak(:,i,:)));
    effect_sizeYZ(i,2) = abs(mean(data.allYlagAtPeak(:,i,:))-mean(data.allZlagAtPeak(:,i,:)))./sqrt(var(data.allYlagAtPeak(:,i,:))+var(data.allZlagAtPeak(:,i,:)));
    effect_sizeYZ(i,3) = abs(nanmean(data.allYwidth(i,:))-nanmean(data.allZwidth(i,:)))./sqrt(nanvar(data.allYwidth(i,:))+nanvar(data.allZwidth(i,:)));
end
effect_sizeYZ = effect_sizeYZ'

% effect average XY Z 
frontoPeaks = squeeze(data.allXpeak + data.allYpeak)./2;
frontoLags = squeeze(data.allXlagAtPeak + data.allYlagAtPeak)./2;
frontoWidths = (data.allXwidth + data.allYwidth)./2;
for i = 1:length(data.theRows)
    effect_sizeXYZ(i,1) = abs(mean(frontoPeaks(i,:))-mean(data.allZpeak(:,i,:)))./sqrt(var(frontoPeaks(i,:))+var(data.allZpeak(:,i,:)));
    effect_sizeXYZ(i,2) = abs(mean(frontoLags(i,:))-mean(data.allZlagAtPeak(:,i,:)))./sqrt(var(frontoLags(i,:))+var(data.allZlagAtPeak(:,i,:)));
    effect_sizeXYZ(i,3) = abs(nanmean(frontoWidths(i,:))-nanmean(data.allZwidth(i,:)))./sqrt(nanvar(frontoWidths(i,:))+nanvar(data.allZwidth(i,:)));
end
effect_sizeXYZ = effect_sizeXYZ'

