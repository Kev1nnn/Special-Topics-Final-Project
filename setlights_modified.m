function  setlights_modified 
global dt tlc ni jgreen_other nbin tlcstep nb s bin n m tcnt tlcstep_main tlcstep_min;

for i=1:ni
    
    if (jgreen_other(i)==1) && (tcnt(i) >= tlcstep_main)
        jgreen_other(i) = jgreen_other(i)+1;
        if (jgreen_other(i)>nbin(i))
            jgreen_other(i)=1;
        end
        tcnt(i)=0;

    end
    if (jgreen_other(i)==2) && (tcnt(i) >= tlcstep_min)
        jgreen_other(i) = jgreen_other(i)+1;
        if (jgreen_other(i)>nbin(i))
            jgreen_other(i)=1;
        end
        tcnt(i)=0;
    end
    tcnt(i) = tcnt(i)+dt;
end

s = zeros(1,nb);
for i = 1:ni
    b = bin(i,jgreen_other(i));
    s(b) = 1;
end




end