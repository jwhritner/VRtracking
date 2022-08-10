%% Plots the aggregate CCGs for all conditions (Figures 2 and 4)

%% Params 
params.fRate = 90; %90 FPS
params.possCoords = {"world" "camera"};
params.whichCoordSys = params.possCoords{2};  % 1 for world, 2 for cam
params.validLen = 1800; % 1800 for 90Hz
params.frontPorch = 180; % 180 for 2 seconds (90 fps)
params.maxLag = 100;  % in frames
params.theLags = -params.maxLag:params.maxLag;
params.theLagsMsec = 1000.*params.theLags./params.fRate;
params.zeroInd = ceil(numel(params.theLags)./2);  % lag zero
params.pLags = params.theLags(params.zeroInd:end); % positive lags
params.pLagsMsec = 1000.*params.pLags./params.fRate;
params.titleStrngs = {'Horizontal','Vertical','Depth'};
black = [0,0,0];
blue = [0,100,200]/255;
red = [200,0,0]/255;
params.lineColors = [blue;red;black];

%% Load the data 
ccg_names = {'exp1sparse','exp1rich','exp2sparse','exp2rich'}; 

for i = 1:length(ccg_names)
    fn = sprintf('%sData.mat',ccg_names{i}); % Load the data
    load(fn);
end 

%% Plot 

% Exp 1 Sparse 
exp1sparseData.Y = [max(exp1sparseData.meanXCX);max(exp1sparseData.meanXCY);max(exp1sparseData.meanXCZ)]; % y values (peaks) for each motion axis (rows) x subject (columns)
exp1sparseData.YNEG = 1.96 .* exp1sparseData.bsData.stdBootPeaks(:,:)'; 
exp1sparseData.YPOS = 1.96 .* exp1sparseData.bsData.stdBootPeaks(:,:)';
exp1sparseData.X = [exp1sparseData.meanXlagAtPeak;exp1sparseData.meanYlagAtPeak;exp1sparseData.meanZlagAtPeak]; % lag values for each motion axis
exp1sparseData.XNEG = 1.96 .* exp1sparseData.bsData.stdBootLags(:,:)';
exp1sparseData.XPOS = 1.96 .* exp1sparseData.bsData.stdBootLags(:,:)';

errbars = 1;
exp1sparseData.N = exp1sparseData.bsData.nConds;
% h = figure;
figure()
nS   = sqrt(exp1sparseData.N);
nCol = ceil(nS);
nRow = nCol - (nCol * nCol - exp1sparseData.N > nCol - 1); % set the number of columns and rows we need, only making a new row if necessary

conds = {'Parallax & Near', 'No Parallax & Near','Parallax & Far', 'No Parallax & Far'};

for kk = 1:exp1sparseData.N
    subplot(nRow, nCol, kk);
    PaperPositionMode = 'manual';
    orient('landscape')
    
    plot(params.pLagsMsec, exp1sparseData.meanXCX(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(1,:))
    hold on;
    plot(params.pLagsMsec, exp1sparseData.meanXCY(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(2,:));
    plot(params.pLagsMsec, exp1sparseData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(3,:));
    if errbars == 1
        errorbar(exp1sparseData.X(:,kk),exp1sparseData.Y(:,kk),exp1sparseData.YNEG(:,kk),exp1sparseData.YPOS(:,kk),exp1sparseData.XNEG(:,kk),exp1sparseData.XPOS(:,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
    end
    
    hold off;
    
    formatFigure('Time lag (ms)', 'Correlation',conds{kk},[],12,10);
    ylim([-.1 .4])
    xlim([0 1200])
    xticks([0:250:1200])
    grid on   
    legend({'X', 'Y', 'Z'},'Location','eastoutside');
    set(gcf,'units','points','position',[0,0,1422,1006])
    sgtitle('Experiment 1 Sparse')
end

% Exp 1 Rich 
exp1richData.Y = [max(exp1richData.meanXCX);max(exp1richData.meanXCY);max(exp1richData.meanXCZ)]; % y values (peaks) for each motion axis (rows) x subject (columns)
exp1richData.YNEG = 1.96 .* exp1richData.bsData.stdBootPeaks(:,:)'; 
exp1richData.YPOS = 1.96 .* exp1richData.bsData.stdBootPeaks(:,:)';
exp1richData.X = [exp1richData.meanXlagAtPeak;exp1richData.meanYlagAtPeak;exp1richData.meanZlagAtPeak]; % lag values for each motion axis
exp1richData.XNEG = 1.96 .* exp1richData.bsData.stdBootLags(:,:)';
exp1richData.XPOS = 1.96 .* exp1richData.bsData.stdBootLags(:,:)';

errbars = 1;
exp1richData.N = exp1richData.bsData.nConds;
figure()
conds = {'Parallax & All Refs & Near', 'Parallax & All Refs & Far','Parallax & Just Walls & Near',...
    'Parallax & Just Walls & Far','No P & All Refs & Near','No P & All Refs & Far','No P & Just Walls & Near',...
    'No P & Just Walls & Far'};

for kk = 1:exp1richData.N
    subplot(2, 4, kk);
    PaperPositionMode = 'manual';
    orient('landscape')
    
    plot(params.pLagsMsec, exp1richData.meanXCX(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(1,:))
    hold on;
    plot(params.pLagsMsec, exp1richData.meanXCY(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(2,:));
    plot(params.pLagsMsec, exp1richData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(3,:));
    if errbars == 1
        errorbar(exp1richData.X(:,kk),exp1richData.Y(:,kk),exp1richData.YNEG(:,kk),exp1richData.YPOS(:,kk),exp1richData.XNEG(:,kk),exp1richData.XPOS(:,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
    end
    
    hold off;
    
    formatFigure('Time lag (ms)', 'Correlation',conds{kk},[],12,10);    
    ylim([-.1 .4])
    xlim([0 1200])
    xticks([0:250:1200])
    grid on    
    legend({'X', 'Y', 'Z'},'Location','eastoutside');
    set(gcf,'units','points','position',[0,0,1422,1006])
    sgtitle('Experiment 1 Rich')
end

% Exp 2 Sparse 
exp2sparseData.Y = [max(exp2sparseData.meanXCX);max(exp2sparseData.meanXCY);max(exp2sparseData.meanXCZ)]; % y values (peaks) for each motion axis (rows) x subject (columns)
exp2sparseData.YNEG = 1.96 .* exp2sparseData.bsData.stdBootPeaks(:,:)'; 
exp2sparseData.YPOS = 1.96 .* exp2sparseData.bsData.stdBootPeaks(:,:)';
exp2sparseData.X = [exp2sparseData.meanXlagAtPeak;exp2sparseData.meanYlagAtPeak;exp2sparseData.meanZlagAtPeak]; % lag values for each motion axis
exp2sparseData.XNEG = 1.96 .* exp2sparseData.bsData.stdBootLags(:,:)';
exp2sparseData.XPOS = 1.96 .* exp2sparseData.bsData.stdBootLags(:,:)';

errbars = 1;
exp2sparseData.N = exp2sparseData.bsData.nConds;
figure()
nS   = sqrt(exp2sparseData.N);
nCol = ceil(nS);
nRow = nCol - (nCol * nCol - exp2sparseData.N > nCol - 1); % set the number of columns and rows we need, only making a new row if necessary

conds = {'No Parallax & Near','No Parallax & Far'};

for kk = 1:exp2sparseData.N
    subplot(nRow, nCol, kk);
    PaperPositionMode = 'manual';
    orient('landscape')
     
    plot(params.pLagsMsec, exp2sparseData.meanXCX(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(1,:))
    hold on;
    plot(params.pLagsMsec, exp2sparseData.meanXCY(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(2,:));
    plot(params.pLagsMsec, exp2sparseData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(3,:));
    if errbars == 1
        errorbar(exp2sparseData.X(:,kk),exp2sparseData.Y(:,kk),exp2sparseData.YNEG(:,kk),exp2sparseData.YPOS(:,kk),exp2sparseData.XNEG(:,kk),exp2sparseData.XPOS(:,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
    end
    
    hold off;
    
    formatFigure('Time lag (ms)', 'Correlation',conds{kk},[],12,10);    
    ylim([-.1 .4])
    xlim([0 1200])
    xticks([0:250:1200])
    grid on
    legend({'X', 'Y', 'Z'},'Location','eastoutside');
    set(gcf,'units','points','position',[0,0,1422,1006])
    sgtitle('Experiment 2 Sparse')
end

% Plotting the CCGs comparing depth tracking from Experiment 1 and Experiment 2 (Figure 8)
figure()
for kk = 1:exp2sparseData.N
    subplot(nRow, nCol, kk); 
    PaperPositionMode = 'manual';
    orient('landscape')
   
    % plotting the exp 2 Z for this condition 
    plot(params.pLagsMsec, exp2sparseData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',[params.lineColors(3,:) 1]);
    hold on 
    % exp 2 error bars
     errorbar(exp2sparseData.X(3,kk),exp2sparseData.Y(3,kk),exp2sparseData.YNEG(3,kk),exp2sparseData.YPOS(3,kk),exp2sparseData.XNEG(3,kk),exp2sparseData.XPOS(3,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
    % plotting the corresponding exp 1 Z - drop opacity (edgealpha?)
    plot(params.pLagsMsec, exp1sparseData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',[params.lineColors(3,:) .4]);
    % exp 1 error bars 
    errorbar(exp1sparseData.X(3,kk),exp1sparseData.Y(3,kk),exp1sparseData.YNEG(3,kk),exp1sparseData.YPOS(3,kk),exp1sparseData.XNEG(3,kk),exp1sparseData.XPOS(3,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
   
    hold off;
    formatFigure('Time lag (ms)', 'Correlation',conds{kk},[],12,10);    
    ylim([-.1 .4])
    xlim([0 1200])
    xticks([0:250:1200])
    grid on   
    legend({'Exp 2 Z',' ','Exp 1 Z'},'Location','eastoutside'); 
    set(gcf,'units','points','position',[0,0,1422,1006]) 
    sgtitle('Experiment 2 Sparse Z vs Experiment 1 Sparse Z')
end

% Exp 2 Rich 
exp2richData.Y = [max(exp2richData.meanXCX);max(exp2richData.meanXCY);max(exp2richData.meanXCZ)]; % y values (peaks) for each motion axis (rows) x subject (columns)
exp2richData.YNEG = 1.96 .* exp2richData.bsData.stdBootPeaks(:,:)'; 
exp2richData.YPOS = 1.96 .* exp2richData.bsData.stdBootPeaks(:,:)';
exp2richData.X = [exp2richData.meanXlagAtPeak;exp2richData.meanYlagAtPeak;exp2richData.meanZlagAtPeak]; % lag values for each motion axis
exp2richData.XNEG = 1.96 .* exp2richData.bsData.stdBootLags(:,:)';
exp2richData.XPOS = 1.96 .* exp2richData.bsData.stdBootLags(:,:)';

errbars = 1;
exp2richData.N = exp2richData.bsData.nConds;
figure()
conds = {'No P & All Refs & Near','No P & Just Walls & Near','No P & All Refs & Far','No P & Just Walls & Far'};

for kk = 1:exp2richData.N
    subplot(1, 4, kk);
    PaperPositionMode = 'manual';
    orient('landscape')
     
    plot(params.pLagsMsec, exp2richData.meanXCX(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(1,:))
    hold on;
    plot(params.pLagsMsec, exp2richData.meanXCY(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(2,:));
    plot(params.pLagsMsec, exp2richData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',params.lineColors(3,:));
    if errbars == 1
        errorbar(exp2richData.X(:,kk),exp2richData.Y(:,kk),exp2richData.YNEG(:,kk),exp2richData.YPOS(:,kk),exp2richData.XNEG(:,kk),exp2richData.XPOS(:,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
    end
    
    hold off;
    
    formatFigure('Time lag (ms)', 'Correlation',conds{kk},[],12,10);    
    ylim([-.1 .4])
    xlim([0 1200])
    xticks([0:250:1200])
    grid on
    legend({'X', 'Y', 'Z'},'Location','eastoutside');
    set(gcf,'units','points','position',[0,0,1422,1006])
    sgtitle('Experiment 2 Rich')
end

% Plotting the CCGs comparing depth tracking from Experiment 1 and Experiment 2 (Figure 10)
figure()
for kk = 1:exp2richData.N
    subplot(1, 4, kk); 
    PaperPositionMode = 'manual';
    orient('landscape')
   
    % plotting the exp 2 Z for this condition 
    plot(params.pLagsMsec, exp2richData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',[params.lineColors(3,:) 1]);
    hold on 
    % exp 2 error bars
     errorbar(exp2richData.X(3,kk),exp2richData.Y(3,kk),exp2richData.YNEG(3,kk),exp2richData.YPOS(3,kk),exp2richData.XNEG(3,kk),exp2richData.XPOS(3,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
    % plotting the corresponding exp 1 Z - drop opacity (edgealpha?)
    plot(params.pLagsMsec, exp1richData.meanXCZ(params.zeroInd:end,kk), 'LineWidth', 2, 'Color',[params.lineColors(3,:) .4]);
    % exp 1 error bars 
    errorbar(exp1richData.X(3,kk),exp1richData.Y(3,kk),exp1richData.YNEG(3,kk),exp1richData.YPOS(3,kk),exp1richData.XNEG(3,kk),exp1richData.XPOS(3,kk),'.','MarkerSize',16,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','Color','k')
   
    hold off;
    formatFigure('Time lag (ms)', 'Correlation',conds{kk},[],12,10);    
    ylim([-.1 .4])
    xlim([0 1200])
    xticks([0:250:1200])
    grid on   
    legend({'Exp 2 Z',' ','Exp 1 Z'},'Location','eastoutside'); 
    set(gcf,'units','points','position',[0,0,1422,1006])
    sgtitle('Experiment 2 Rich Z vs Experiment 1 Rich Z')
end



