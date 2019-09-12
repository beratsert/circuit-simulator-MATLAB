function imat = BuildingImat(imat,numi,inew)
%I wanted to build the matrix of i
for i=1:numi(1)
      if inew(i,1)~=0
      as=inew(i,1);
      imat(as,1)=imat(as,1)-inew(i,3);
      end
      bs=inew(i,2);
      if bs~=0
      imat(bs,1)=imat(bs,1)+inew(i,3);
      end
end
end

