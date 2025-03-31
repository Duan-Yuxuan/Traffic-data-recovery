clc,clear all
% filename='Geant_OOTD_complete.mat';
filename='Abilene_OOTD.mat';%Abilene数据
MM=importdata(filename);
Ma=MM(:,:,:,1:7);
M=permute(Ma,[4,3,2,1]);
[n1,n2,n3,n4]=size(M);
Omegaa=Ma;
[nn1,nn2,nn3,nn4]=size(Ma);
%%
iii=0.9;
Omegaa(randperm(nn1*nn2*nn3*nn4,floor(nn1*nn2*nn3*nn4*iii)))=-1*ones(floor(nn1*nn2*nn3*nn4*iii),1);
Omega=permute(Omegaa,[4,3,2,1]);
%% xxTimeRandLoss
% xx=0.5;xq=0.9;
% Omega_matrix=reshape(Omegaa,[nn1*nn2,nn3*nn4]);
%   Omega_Matrix=Omega_matrix;
%     a=1:nn3*nn4;b=a(randperm(numel(a),round(nn3*nn4*xx)));
%     for c=1:length(b)
%         d=b(c);
%         e=Omega_matrix(:,d);
%         e(randperm(nn1*nn2,floor(nn1*nn2*xq)))=-1*ones(floor(nn1*nn2*xq),1);
%         Omega_Matrix(:,d)=e;
%     end
%     Omegaa=reshape(Omega_Matrix,[nn1,nn2,nn3,nn4]);
%     Omega=permute(Omegaa,[4,3,2,1]);
    %% xxElemRandLoss
  
%     xx=0.5;xq=0.8;
% Omega_matrix=reshape(Omegaa,[nn1*nn2,nn3*nn4]);
%     Omega_Matrix=Omega_matrix;
%     a=1:nn1*nn2;b=a(randperm(numel(a),round(nn1*nn2*xx)));
%     for c=1:length(b)
%         d=b(c);
%         e=Omega_matrix(d,:);
%         e(randperm(nn3*nn4,floor(nn3*nn4*xq)))=-1*ones(1,floor(nn3*nn4*xq));
%         Omega_Matrix(d,:)=e;
%     end
%     Omegaa=reshape(Omega_Matrix,[nn1,nn2,nn3,nn4]);
%     Omega=permute(Omegaa,[4,3,2,1]);
%%
canshu=[0.001 0.01 0.1 1 2 5 10 15 20 50 100 200 500 800 1000 2000 2500 3000 3500 5000 6000 8000 10000];
% canshu=[20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100];
for a2=1:length(canshu)
opts.alpha1=0.1;%0.1
opts.alpha2=100;%100-200,50-500,200
opts.beta1=0.01;%0.01基本无影响
opts.beta2=0.1;%10
opts.lambda=0.001;%amae无影响，时间上影响也不大
opts.tol=1e-4;
opts.iter=150;
% a3=1:25;
% for a2=1:length(a3)
s=4;
X=rand(n1,n2,n3,n4);
A=rand(n1,s,n3,n4);
B=rand(s,n2,n3,n4);
Y=rand(n1,n2,n3,n4);
Z=rand(n1,n2,n3,n4);
W1=rand(n1,n2,n3,n4);
W2=rand(n1,n2,n3,n4);
Out=SRdTNN(X,A,B,Y,Z,W1,W2,M,Omega,s,opts);
X=Out.X;
Aa=zeros(n1,n2,n3,n4);
for i=1:n1
    for j=1:n2
        for k=1:n3
            for l=1:n4
                if Omega(i,j,k,l)==-1
                    Aa(i,j,k,l)=M(i,j,k,l);
                else
                    Aa(i,j,k,l)=0;
                end
            end
        end
    end
end
norm_A=sum(abs(reshape(Aa,[n1*n2*n3*n4,1])));
time=Out.time;
NMAE =sum(abs(reshape(X-M,[n1*n2*n3*n4,1])))/norm_A;
fprintf('nmae=%.3f,time=%.3f \n',NMAE,time);
end

