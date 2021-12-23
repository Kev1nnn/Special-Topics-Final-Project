function  movecars
global nb firstcar nextcar lastcar bd pd p L dmax nextb x y xd yd i1 ux uy xi yi dt s onroad prchoice nbout bout xdvec ydvec i2 vmean speed_zero t total_len; 
vtotal =0;
cnt = 0;
cnt_zero=0;
for b = 1:nb
    c = firstcar(b);
    ca = c;
    while(c>0)
        if (c == firstcar(b))
            if (bd(c) == b && (pd(c)>p(c)))
                d = dmax;
            elseif (s(b)==0)
                d = L(b)-p(c);
            else
   
                decidenextbook(b,c);
                if(lastcar(nextb(c))>0)
                    d = (L(b)-p(c))+p(lastcar(nextb(c)));
                else
                    d = dmax;
                end
            end
        else
            d = p(ca)-p(c);
        end
        pz = p(c);
        nextc = nextcar(c);
        p(c) = p(c)+dt*v(d);
        if (v(d)==0)
            cnt_zero = cnt_zero+1;
        end

        vtotal = vtotal + v(d);
        cnt = cnt+1;
        if (b==bd(c)&& (pz < pd(c)))&& (pd(c)<= p(c))
            removecar(c,b,ca);
        elseif (L(b)<=p(c))
            p(c) = p(c)-L(b);
            if (nextb(c)==bd(c))&& (pd(c)<=p(c))
                removecar(c,b,ca);
            else
                cartonextblock(b,c);
            end
        else
            x(c) = xi(i1(b))+p(c)*ux(b);
            y(c) = yi(i1(b))+p(c)*uy(b);
            ca = c;
        end
        c=nextc;
    end
end
vmean = vtotal/cnt;
speed_zero(t) = cnt_zero;
end

