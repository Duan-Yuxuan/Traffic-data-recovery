function K=funk(p)
K=zeros(p-1,p);
for i=1:p-1
	for j=1:p
		K(i,i)=1;
		K(i,i+1)=-1;
	end
end