% calculate the DCM from the prespecified DCMs

% need spm12 on path to calculate the DCM
% this script was run multiple times with the following input output pairs
% for_the_cloud.mat -> Rest1_Group1.mat
% for_the_cloud2.mat -> Rest2_Group1.mat
% Cloud_V2_1.mat -> Rest1_Group2.mat
% Cloud_V2_2.mat -> Rest2_Group2.mat

% within each of the runs DCM6_csd had _v2_1 and _v2_2 added for
% Cloud_V2_1.mat and Cloud_V2_2.mat repectively, as well as 2 added for
% for_the_cloud2.mat. Hence the variables extracted in Analysis/analysis_and_figures.m 

load('for_the_cloud.mat') % 
k=length(DCM6);

DCM6_csd=cell(k,1);


parfor i=1:k
DCM6_csd(i)={spm_dcm_fmri_csd(DCM62{i})}; 
end

save('Rest1_Group1.mat')