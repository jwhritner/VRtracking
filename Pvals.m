%% P values for tracking features 

% load the data you want
load('exp1sparseData.mat')
data = exp1sparseData; 
bsData = exp1sparseData.bsData;

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
