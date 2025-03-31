function B=subB(A,X,lambda,n2,n3,n4,s)
%求解V子问题
 for m=3:4
    XL=fft(X,[],m)/sqrt(n3);
    AL=fft(A,[],m)/sqrt(n3);
 end
 Is=eye(s);
 BL=zeros(s,n2,n3,n4);
 for k=1:n3
     for l=1:n4
         BL(:,:,k,l)=(Is/(lambda*AL(:,:,k,l)'*AL(:,:,k,l)+Is))*(lambda*AL(:,:,k,l)'*XL(:,:,k,l));
     end
 end
for m=3:4
     B=ifft(BL,[],m)*sqrt(n3);
end