function ReadTextfile(filename)
% is needed to open text
fid=fopen(filename,'rt');
% if the file does not open, this will send us a massage 
if fid < 0
    error('ERROR OPENING FILE %s\n\n',filename);
end
% textscan serves to save the netlist as a cell array
  c1=textscan(fid,'%s %f %f %f');
%  this gives the number of component
numcomp=size(c1{1,1});
  c=1;
%   I wanted to spare resistors and formed a new matrix r
  r=zeros(numcomp(1),3);
 
     for i=1:numcomp(1)
             if c1{1,1}{i}(1,1)=='R'
             r(c,1)=c1{1,2}(i);
             r(c,2)=c1{1,3}(i);
             r(c,3)=c1{1,4}(i);
             c=c+1;
             end
    end
%   Found the number of nodes.
n=max(c1{1,3});
%   Formed nxn zero matrix and it will turn G matrix by dint of 
G=zeros(n,n);
G = BuildingG(r,G,numcomp,n);
% Then I wanted to regroup voltage sources.
d=1;
    for i=1:numcomp(1)
             if c1{1,1}{i}(1,1)=='V'
             v(d,1)=c1{1,2}(i);
             v(d,2)=c1{1,3}(i);
             v(d,3)=c1{1,4}(i);
             d=d+1;
             end
    end
    m=size(v);
% regrouping data makes building B matrix easier 
  B=zeros(n,m(1));
  B = BuildingB(v,m,B);
%   the C matrix is the transpose of the B matrix.  
% (This is not the case when dependent sources are present.)
 C=B';
%  The D matrix is an mxm matrix that is composed entirely of zeros.  
%  (It can be non-zero if dependent sources are considered.)
D=zeros(m(1),m(1));
% I can form A matrix because I formed all submatrixes of A.
A=[G,B;C,D];
% Z=[i;e]
d=d-1;
e=zeros(d,1);
for i=1:d
    e(i,1)=v(i,3);
end
% I will sort I sources and form i.
is=1;
inew=zeros(numcomp(1),3);
for i=1:numcomp(1)
             if c1{1,1}{i}(1,1)=='I'           
             inew(is,1)=c1{1,2}(i);
             inew(is,2)=c1{1,3}(i);
             inew(is,3)=c1{1,4}(i);
             is=is+1;
             end
    
end
numi=size(inew);
imat=zeros(n,1);
  imat = BuildingImat(imat,numi,inew);
  z=[imat;e];
  q=m(1)+n;
  x=zeros(q,1);
%   x=inv(A)*z 
  x = XGonGiveItToYa(A,z,x);
%   This gives the results.
  for i=1:n
  fprintf('V%d=%.2f\n',i,x(i,1));
  end
end