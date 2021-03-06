A=[1,-1,2;
    -1,2,-4;
    2,-4,9];
B=[-1;4;-9];
Ag={};                                                  %Create a cell array to store each matrix
Aau=[A,B];                                              %Generate the augmented matrix
Ag{1}=Aau;                                              %Store the first initial matrix
[n,b]=size(A);
m=[];
for i=1:n-1
    %Check and switch to check pivot to be not 0
    p=i;
    while Aau(p,i)==0 & p <= n-1    
        p=p+1;
    end
    if p==n & Aau(p,i)==0
        disp("No unique solution found, please check");
        break
    end
    Atemp=Aau(i,:);
    Aau(i,:)=Aau(p,:);
    Aau(p,:)=Atemp;
    if i ~= p
        frpintf("switch the row %d with %d \n",i,p);
    end
    fprintf("Perform the operation \n")
    for j=i+1:n
        m(j,i)=Aau(j,i)/Aau(i,i);
        Aau(j,:)=Aau(j,:)-m(j,i).*Aau(i,:);
        mr(j,i)=round(m(j,i),2);
        fprintf(" $ ( E_{%d} - (%4.2f) E_{%d}) \\rightarrow (E_{%d}) $, ",j,mr(j,i),i,j);
        Aau=round(Aau,2);
    end
    fprintf("\n \n")
    Ag{i +1}=Aau;
    display_aug_mat(Aau);
    fprintf("\n \n")

end

if Aau(n,n)== 0
    disp("No unique Solution Exist");
else


fprintf("\n \n")
    % Start the backward substituition
    x=[];
    x(n)=Aau(n,n+1)/Aau(n,n);
    xn=round(x(n),2);
    fprintf("$$ \n x_{%d}=%4.2f \n $$ \n",n,xn)
    x(n)=round(x(n),2);
    for i=n-1:-1:1
        sum=0;
        for j=i+1:n
            sum=sum+Aau(i,j)*x(j);
        end
        x(i)=(Aau(i,n+1)-sum)/Aau(i,i);
        x(i)=round(x(i),2);
        fprintf("$$ \n x_{%d}=\\left[a_{%d, %d}-\\sum_{j=%d}^{%d} a_{%d j} x_{j}\\right] / a_{%d %d}=%4.2f \n $$ \n",i,i,n+1,i+1,n,i,i,i,x(i));
    end
end

disp(x);

