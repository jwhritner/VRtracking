% Plotting the distributions of relative disparities (Figures 6 and 7) 

load('bonnenDisps.mat')
load('exp1sparseFarDisps.mat')
load('exp1sparseNearDisps.mat')
load('exp2sparseFarDisps.mat')
load('exp2sparseNearDisps.mat')
clc

% Exp 1 subplot with the cumulative densities 
figure()
subplot(1,2,1)
histogram(bonnenDisps,linspace(-40,40,50),'normalization','probability','FaceColor','r','FaceAlpha',.4)
hold on
histogram(exp1sparseNearDisps,linspace(-40,40,50),'normalization','probability','FaceColor','b','FaceAlpha',.4)
histogram(exp1sparseFarDisps,linspace(-40,40,50),'normalization','probability','FaceColor','c','FaceAlpha',.4)
xlim([-40 40])
xticks(-40:10:40)
ylim([0 .4])
yticks(0:.1:.4)
formatFigure('target-cursor disparity (arcmin)', 'Cumulative counts');
legend('Bonnen','Exp. 1 Near','Exp. 1 Far','Location','east')
subplot(1,2,2)
histogram(bonnenDisps,linspace(-40,40,50),'normalization','cdf','FaceColor','r','FaceAlpha',.4)
hold on
histogram(exp1sparseNearDisps,linspace(-40,40,50),'normalization','cdf','FaceColor','b','FaceAlpha',.4)
histogram(exp1sparseFarDisps,linspace(-40,40,50),'normalization','cdf','FaceColor','c','FaceAlpha',.4)
xlim([-40 40])
xticks(-40:10:40)
ylim([0 1.1])
formatFigure('target-cursor disparity (arcmin)', 'Cumulative counts');
legend('Bonnen','Exp. 1 Near','Exp. 1 Far','Location','west')
sgtitle('Exp 1 Disparity Distributions')

% Exp 2
figure()
subplot(1,2,1)
histogram(bonnenDisps,linspace(-40,40,50),'normalization','probability','FaceColor','r','FaceAlpha',.4)
hold on
histogram(exp2sparseNearDisps,linspace(-40,40,50),'normalization','probability','FaceColor','b','FaceAlpha',.4)
histogram(exp2sparseFarDisps,linspace(-40,40,50),'normalization','probability','FaceColor','c','FaceAlpha',.4)
xlim([-40 40])
xticks(-40:10:40)
ylim([0 .4])
yticks(0:.1:.4)
formatFigure('target-cursor disparity (arcmin)', 'Cumulative counts');
legend('Bonnen','Exp. 1 Near','Exp. 1 Far','Location','east')
subplot(1,2,2)
histogram(bonnenDisps,linspace(-40,40,50),'normalization','cdf','FaceColor','r','FaceAlpha',.4)
hold on
histogram(exp2sparseNearDisps,linspace(-40,40,50),'normalization','cdf','FaceColor','b','FaceAlpha',.4)
histogram(exp2sparseFarDisps,linspace(-40,40,50),'normalization','cdf','FaceColor','c','FaceAlpha',.4)
xlim([-40 40])
xticks(-40:10:40)
ylim([0 1.1])
formatFigure('target-cursor disparity (arcmin)', 'Cumulative counts');
legend('Bonnen','Exp. 2 Near','Exp. 2 Far','Location','west')
sgtitle('Exp 2 Disparity Distributions')



