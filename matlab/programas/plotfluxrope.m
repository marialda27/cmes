function [times,dists] = plotfluxrope(maxtime,hcrom)

% maxtime: máximo tiempo a considerar
% hcrom: altura de la cromósfera por encima de la cual se considera la
%        densidad máxima para localizar al flux rope

intervaltime = 5.0; 
time = 0.0;
nfile = 0;
niter = 1;

while time <= maxtime
    
    
    [coords,dens,currtime,nfile] = getdensline(time,'x',1.,nfile);
    
    ncoord = max(size(coords));
    
    [sortdens,sortidx] = sort(dens,'descend');
    sortcoords = coords(sortidx);
    
    for i = 1:ncoord
        if niter > 1
            if (sortcoords(i) > dists(niter-1))
                dists(niter) = sortcoords(i);
                times(niter) = currtime;
                break
            end
        else
            if (sortcoords(i) > hcrom)
                dists(niter) = sortcoords(i);
                times(niter) = currtime;
                break
            end
        end
    end
    
    niter = niter + 1;
    nfile = nfile + 1;
    time = time + intervaltime; 
end


figure; plot(times,dists/(1.e2*1.e6),'ob'), % dists en Mm