function  setlights 
global t tlc ni jgreen nbin tlcstep nb s bin n m;
if (t>tlc)
    for i=1:ni
        jgreen(i) = jgreen(i)+1;
        if (jgreen(i)>nbin(i))
            jgreen(i)=1;
        end
    end
    tlc = tlc + tlcstep;
end
s = zeros(1,nb);
for i = 1:ni
    b = bin(i,jgreen(i));
    s(b) = 1;
end

end
