function pruebahydrostatic(coords,pres,magx,magy)

rr  = 2.5e8;
Del = 1.25e8;
j0  = 1000;
c = 2.99792458e10;

phydro = pres(1);

ncells = max(size(coords));
dx = coords(2) - coords(1);

for i = 1:ncells
    x = coords(i);
    if (abs(coords(i)) < (rr + Del/2.))
        
        intjB = 0;
        for j = 1:i;         
            if (abs(coords(j)) <= (rr-Del/2));
                jz = j0;
            elseif (abs(coords(j)) > (rr-Del/2) && abs(coords(j)) <= (rr + Del/2))
                jz = 0.5*j0* (cos(pi*(abs(coords(j)) - rr + Del/2.)/Del) + 1.);
            else
                jz = 0;
            end
            if j < i;
                intjB = dx/c*jz*magy(j) + intjB;
            else
                intjB = dx/2/c*jz*magy(j) + intjB;
            end
        end
        pnew(i) = phydro - intjB;
    else
        pnew(i) = phydro;
            
    end        
        
end

for i = 2:ncells-1;
    if (abs(coords(i)) <= (rr-Del/2));
        jz = j0;
    elseif (abs(coords(i)) > (rr-Del/2) && abs(coords(i)) <= (rr + Del/2));
        jz =  0.5d0*j0* (cos(pi*(abs(coords(i)) - rr + Del/2.)/Del) + 1.);
    else
        jz = 0;
    end
    d2(i) = -1/c*jz*magy(i);
    dpdx(i) = (pres(i+1)-pres(i-1))/(coords(i+1)-coords(i-1));
    dpnewdx(i) = (pnew(i+1)-pnew(i-1))/(coords(i+1)-coords(i-1));
end
    
figure; plot(coords(1:ncells-1),dpdx,'o-k'), hold on;
plot(coords(1:ncells-1),d2,'o-b');
plot(coords(1:ncells-1),dpnewdx,'o-r')

figure; plot(coords,pres,'o-k'); hold on; plot(coords,pnew,'o-r')
