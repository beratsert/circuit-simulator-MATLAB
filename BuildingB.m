 function B = BuildingB(v,m,B)
% I formed the one of the submatrixes of A, B
for i=1:m(1)
    if v(i,1)~=0
        k=v(i,1);
        B(k,i)=-1;
    end
    l=v(i,2);
    B(l,i)=1;
  
end
end

