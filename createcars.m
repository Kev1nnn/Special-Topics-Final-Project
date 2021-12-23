function  createcars
global nb nc L R dt p x y xi yi ux uy onroad nextb tenter benter penter i1 firstcar nextcar lastcar Lmax t;
for b = 1:nb
    if (rand<dt*R*L(b))
        nc = nc+1;
        p(nc) = rand*L(b);
        x(nc) = xi(i1(b)) + p(nc)*ux(b);
        y(nc) = yi(i1(b)) + p(nc)*uy(b);
        onroad(nc) = 1;
        insertnewcar(b);
        Lmax = max(L);
        choosedestination;
        nextb(nc)=b;
        tenter(nc) = t;
        benter(nc) = b;
        penter(nc) = p(nc);
    end
end
end