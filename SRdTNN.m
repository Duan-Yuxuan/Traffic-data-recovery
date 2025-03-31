function Out=SRdTNN(X,A,B,Y,Z,W1,W2,M,Omega,s,opts)
%% X、Y、Z、W1、W2、M、Omega\in[n1*n2*n3*n4],A\in[n1*s*n3*n4],B\in[s*n2*n3*n4]
% Omega为观测数据索引值，其中未观测到的值赋-1，因此只需要查找Omega中-1的位置
%%

t0=tic;
[n1,n2,n3,n4]=size(M);
alpha1=opts.alpha1;
alpha2=opts.alpha2;
beta1=opts.beta1;
beta2=opts.beta2;
lambda=opts.lambda;
gamma=opts.gamma;
tol=opts.tol;
iter=opts.iter;
%% Y、Z子问题采用chol分解
In1=eye(n1);
H=funk(n1);
HH=alpha1*(H'*H)+(beta1+gamma)*In1;%Y中三对角系数矩阵
R1=chol(HH);invRT1=In1/(R1');invR1=In1/R1;%得到分解后矩阵的逆

K=funk(n2);
In2=eye(n2);
KK=alpha2*(K'*K)+(beta2+gamma)*In2;%Z中三对角系数矩阵
R2=chol(KK);invRT2=In2/(R2');invR2=In2/R2;%得到分解后矩阵的逆
%% =================================================================================== %%循环迭代
for aaa=1:iter
    X_last=X;
    X=subX(A,B,Y,Z,M,W1,W2,Omega,lambda,beta1,beta2,n1,n2,n3,n4);
    A=subA(X,B,lambda,n1,n3,n4,s);
    
    B=subB(A,X,lambda,n2,n3,n4,s);
  
    Y=subY(X,invRT1,invR1,W1,beta1,n1,n2,n3,n4);

    Z=subZ(X,invRT2,invR2,W2,beta2,n1,n2,n3,n4);
    
    W1=W1+beta1*(X-Y);
    W2=W2+beta2*(X-Z);

    

    

    %% stopping rule
    err=norm(X_last(:)-X(:))/norm(X(:));

    if  err<tol && aaa>=20
      X=X;    
    break;
    end
end
T=toc(t0);
Out.X=X;
Out.time=T;
Out.iter=aaa;






