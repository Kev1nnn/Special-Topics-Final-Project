clear all;
global firstcar lastcar nextb nextcar i1 xi yi ux uy x y p;
global nb firstcar nextcar lastcar bd pd p L dmax nextb ca x y xd yd i1 ux uy xi yi dt s onroad prchoice nbout bout xdvec ydvec i2; 
global t tlc ni jgreen nbin tlcstep b nb s;
global onroad firstcar nextcar lastcar ca x y xd yd texit;
global nb nc L R dt p x y xi yi ux uy onroad nextb tenter benter penter i1 firstcar nextcar lastcar Lmax t;
global nextb prchoice nbout bout xdvec ydvec ux uy i2;
global dmin dmax vmax;
global nc nb bd pd xd yd xi yi i1 ux uy Lmax;
global firstcar nextcar lastcar p nc ca bin ncmax vmean  tcnt jgreen_other speed_zero;
n = 3;
m = 30;
nc = 0;
ni = (n+1)*m;
nb = m*n+(m-1)*(n+1);
i1 = zeros(nb,1);
i2 = zeros(nb,1);

for i= 0:n
    for j = 1:m-1
        if mod(i,2)==0
            i1(i*(m-1)+j) = i*m+j;
            i2(i*(m-1)+j) = i*m+j+1;
        else
            i1(i*(m-1)+j) = i*m+j+1;
            i2(i*(m-1)+j) = i*m+j;
        end
    end
end 
tmp = (m-1)*(n+1);
for i = 0:n-1
    for j = 1:m
        if mod(j,2)==0
            i1(tmp+i*m+j) = i*m+j;
            i2(tmp+i*m+j) = (i+1)*m+j;
        else
            i2(tmp+i*m+j) = i*m+j;
            i1(tmp+i*m+j) = (i+1)*m+j;
        end
    end
end

nbin = zeros(ni,1);
nbout = zeros(ni,1);
for i = 1:ni
    nbin(i) = sum(i2 ==i);
    nbout(i) = sum(i1==i);
end

nbinmax = max(nbin);
nboutmax = max(nbout);
bin = zeros(ni,nbinmax);
bout = zeros(ni,nboutmax);
for i = 1:ni
    bin(i,1:nbin(i)) = find(i2==i);
    bout(i,1:nbout(i)) = find(i1==i);
end
xi = zeros(ni,1);
yi = zeros(ni,1);

for i= 0:n
    for j = 1:m
        xi(i*m+j) = 240*i;
        yi(i*m+j) = 80*(j-1);
    end
end

ncmax = 1000000;
dmax = 500;
dmin = 3;
vmax = 11;
ux = zeros(nb,1);
uy = zeros(nb,1);
for i = 1:nb
    ux(i) = xi(i2(i)) - xi(i1(i));
    uy(i) = yi(i2(i)) - yi(i1(i));
end
L = sqrt(ux.^2+uy.^2);
ux = ux./L;
uy = uy./L;
timeuntilgreen = zeros(ni,1);

set = ones(1,ni);
jgreen_other = ones(1,ni);
jgreen = ones(ni,1);
for i= 1:ni
    if mod (i,2)==1 && i~=1 && mod(i-1,60)~=0 && i<=m*n 
        set(i) = 2;
    end
    if i> m*n && mod(i,2)==0 && i~=ni
        set(i) = 2;
    end
end
global tlcstep_main tlcstep_min;

tcnt = zeros(1,ni);
num_blk = 2;
avg_spd = 12;
tlcstep_main = num_blk*avg_spd;
tlcstep_min = num_blk*avg_spd;
for i = 0:n
    for j = 1:m
        if mod(i,2)==0
            int = fix((j-1)/num_blk);
            rem = mod(j-1,num_blk);
            if (mod(int,2)==0)
                if (bin(i*m+j,2)~=0)
                    jgreen_other(i*m+j) = 1;
                end
            else
                if (bin(i*m+j,2)~=0)
                    jgreen_other(i*m+j) = 2;
                end
            end
            tcnt(i*m+j) = avg_spd*(num_blk-rem);

        else
            int = fix((j-1)/num_blk);
            rem = mod(j-1,num_blk);
            if (mod(int,2)==0)
                if (bin(i*m+j,2)~=0)
                    jgreen_other(i*m+j) = 1;
                end
            else
                if (bin(i*m+j,2)~=0)
                    jgreen_other(i*m+j) = 2;
                end
            end
            tcnt(i*m+j) = avg_spd*(rem+1);
        end
    end
end

tlcstep = 50;

tlc = tlcstep;
clockmax = 3000;
dt = 1;

prchoice = 0.2;
firstcar = zeros(nb,1);
nextcar = zeros(ncmax,1);
lastcar = zeros(nb,1);
bd = zeros(ncmax,1);
pd = zeros(ncmax,1);

vmeanlist = zeros(clockmax,1);
R = 2.6e-5;

% tic
% jump = 1;
% writerObj = VideoWriter('Stagger.avi');
% writerObj.FrameRate = 20;
% [~,~,frames] = size(clockmax);
% frames = floor(frames/jump);
% open(writerObj);
% Framevideo(frames) = struct('cdata',[],'colormap',[]);
global total_len;
total_len = 0;
for clock = 1:clockmax
    t = clock*dt;
    setlights_modified;
    createcars;
    movecars;
    vmeanlist(clock) = vmean;
    if (nc>0 && sum(onroad)>0)
        %figure(1)
        %plot(x(find(onroad)),y(find(onroad)),'*');
        %fig = gcf;
        %drawnow
        %Framevideo(clock) = getframe(gcf);
        %writeVideo(writerObj,Framevideo(clock));
        %pause(.001)
        %shg
    end
end
%close(writerObj);
xlist = 1:1:clockmax;
plot(xlist,vmeanlist);
xlabel('time(s)');
ylabel('Mean Velocity(m/s)');
disp(mean(vmeanlist(2000:3000)));
disp(var(vmeanlist(2000:3000)));
for i = 1:3000
    if vmeanlist(i)<0.1
        disp(i);
        break;
    end
end
