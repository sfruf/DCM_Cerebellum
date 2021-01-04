%new group level DCM analysis that looks at whether there are meaningful
%group differences between the two DCM groups


load('Rest1_Group1.mat','DCM6_csd') %RS Session 1 Subject Group 1
load('Rest2_Group1.mat','DCM6_csd2')%RS Session 2 SG 1
DCM6_csd2(end)=[];
load('Rest1_Group2.mat','DCM6_csd_v2_1')%RS Ses 1 Subject Group 2
load('Rest2_Group2.mat','DCM6_csd_v2_2')%RS Ses 2 SG 2
n=length(DCM6_csd);
%%
[PEB6,P6]=spm_dcm_peb([DCM6_csd(:),DCM6_csd2(:);DCM6_csd_v2_1(:),DCM6_csd_v2_2(:)]);

%% graphs
spm_dcm_peb_review(PEB6)


%% manually copied from peb_review because I can't figure out SPM
A=zeros(6,6);
A(1,1)=-.876;
A(4,1)=.279;
A(1,2)=.129;
A(3,2)=.150;
A(2,2)=-.582;
A(5,2)=.349;
A(2,3)=.111;
A(3,3)=-.720;
A(4,3)=-.138;
A(6,3)=.295;
A(1,4)=.216;
A(4,4)=-.158;
A(6,4)=.120;
A(5,5)=.186;
A(6,5)=.155;
A(2,6)=-.196;
A(3,6)=.215;
A(4,6)=.238;
A(5,6)=.122;
%A2=zeros(6,6);
%A2(3,3)=-.120;
%A2(1,4)=.141;

display_DCM(A,{'DMN CC','Motor CC','Task CC','DMN C','Motor C','Task C'},1)
title('PEB DCM Mean')

print('High_Res_mean','-dpng','-r0')
%
A_bet=A;
A_bet(eye(6)>0)=0;
A_bet(1,4)=0;
A_bet(4,1)=0;
A_bet(2,5)=0;
A_bet(5,2)=0;
A_bet(3,6)=0;
A_bet(6,3)=0;
display_DCM(A_bet,{'DMN CC','Motor CC','Task CC','DMN C','Motor C','Task C'},1)
title('PEB DCM Mean Between Networks')
print('High_Res_between','-dpng','-r0')