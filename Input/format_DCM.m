Resting_state=1; %Resting_state=2 loads the second resting state run 
% script was run twice in each sub-directory that contained HCP outputs
% from the 1st and 2nd group of patients

if Resting_state==1
    rest_bfolder="MNINonLinear/Results/rFMRI_REST1_LR";
elseif Resting_state==2
    rest_folder="MNINonLinear/Results/rfMRI_REST2_LR";
end

%% iterate over every folder

% Get a list of all files and folders in this folder.
files = dir;
% Get a logical vector that tells which is a directory.
dirFlags = [files.isdir];
% Extract only those that are directories.
subFolders = files(dirFlags);
subFolders=subFolders(3:end-3); %cuts off two hidden folders
%%
T=length(subFolders);
timeseries9=cell(T,1);
timeseries6=cell(T,1);
DCM6=cell(T,1);
list=cell(T,1);
for k = 1 : T
    list{k}=subFolders(k).name;
    cd(subFolders(k).name)
    cd(rest_folder)
    grad1max_left=importdata('left_grad1max.txt','\n');
    grad1max_right=importdata('right_grad1max.txt','\n');
    grad1max=importdata('comb_grad1max.txt','\n');
    
    grad1min_left=importdata('left_grad1min.txt','\n');
    grad1min_right=importdata('right_grad1min.txt','\n');
    grad1min=importdata('comb_grad1min.txt','\n');
    
    
    grad2max_left=importdata('left_grad2max.txt','\n');
    grad2max_right=importdata('right_grad2max.txt','\n');
    grad2max=importdata('comb_grad2max.txt','\n');
    
    cerb1max=importdata('cerb_grad1max.txt','\n');
    cerb1min=importdata('cerb_grad1min.txt','\n');
    cerb2max=importdata('cerb_grad2max.txt','\n');
    
    
    
    timeseries6{k}=[grad1max';
        grad1min';
        grad2max';
        cerb1max';cerb1min';cerb2max']';
    n6=size(timeseries6{k},2);
    timehorizon6=size(timeseries6{k},1);
    %need to specify the following
    % DCM.a                              % switch on endogenous connections
    DCM6_holder.a=ones(n6,n6); %specify a fully connected graph
    % DCM.b                              % switch on bilinear modulations
    DCM6_holder.b=zeros(n6,n6); %how input can change structure
    % DCM.c                              % switch on exogenous connections
    DCM6_holder.c=zeros(n6,1); %exogenous effect of input
    % DCM.d                              % switch on nonlinear modulations
    DCM6_holder.d=double.empty(n6,n6,0);
    % DCM.U                              % exogenous inputs
    DCM6_holder.U.u    = zeros(timehorizon6,1);
    DCM6_holder.U.name = {'null'};
    DCM6_holder.U.dt=.72;
    % DCM.Y.y                            % responses (time series data
    DCM6_holder.Y.y=timeseries6{k};    %time series is time by node
    DCM6_holder.Y.dt=.72;
    % DCM.Y.X0                           % confounds (time series)
    
    % DCM.Y.Q                            % array of precision components
    DCM6_holder.Y.Q        = spm_Ce(ones(1,n6)*timehorizon6);
    % DCM.n                              % number of regions
    DCM6_holder.n=n6;
    % DCM.v                              % number of scans
    DCM6_holder.v=timehorizon6;
    %optional extras
    %DCM.TE=echotime;
    DCM6_holder.delays=ones(n6,1); %default slice timing delays
    DCM6_holder.options.nonlinear=0;
    DCM6_holder.options.two_state=0;
    DCM6_holder.options.stochastic=1;
    DCM6_holder.options.centre=0;
    DCM6_holder.options.induced=1; %CSD calculation
    DCM6{k}=DCM6_holder;
    cd("/Volumes/My Passport for Mac/HCP files")
end

save_str=sprintf('Cloud_V2_%i.mat',Resting_state);
save(save_str)


