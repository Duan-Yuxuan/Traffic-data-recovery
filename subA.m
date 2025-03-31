function A=subA(X,B,lambda,n1,n3,n4,s)
%求解U子问题
 for m=3:4
    XL=fft(X,[],m)/sqrt(n3);
    BL=fft(B,[],m)/sqrt(n3);
 end
 Is=eye(s);
 AL=rand(n1,s,n3,n4);
 for k=1:n3
     for l=1:n4
         AL(:,:,k,l)=lambda*XL(:,:,k,l)*BL(:,:,k,l)'/(lambda*BL(:,:,k,l)*BL(:,:,k,l)'+Is);
     end
 end
 for m=3:4
     A=ifft(AL,[],m)*sqrt(n3);
 end