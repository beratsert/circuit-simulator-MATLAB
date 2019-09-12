function G = BuildingG(r,G,numcomp,n)
% Firstly,I formed the diagonal values.Afterwards, I added the other
% values.


for x=1:n
for i=1:numcomp(1)
if r(i,1)==x || r(i,2)==x
    G(x,x)=G(x,x)+1/r(i,3); 
end
end
end

for i=1:numcomp(1)
    if r(i,1)~=0 
    a=r(i,1);
    b=r(i,2);
    G(a,b)=G(a,b)-1/r(i,3);
    G(b,a)=G(b,a)-1/r(i,3);
    end
end

end

