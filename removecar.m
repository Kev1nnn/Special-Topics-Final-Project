function  removecar(c,b,ca)
global onroad firstcar nextcar lastcar x y xd yd texit t;
onroad(c)=0; 
texit(c)=t;
if (c==firstcar(b))
    firstcar(b) = nextcar(c);
    if (c == lastcar(b))
        lastcar(b)=0;
    end
else
    nextcar(ca)=nextcar(c);
    if (c == lastcar(b))
        lastcar(b) = ca;
    end
end
x(c) = xd(c);
y(c) = yd(c);
nextcar(c) = 0;

end