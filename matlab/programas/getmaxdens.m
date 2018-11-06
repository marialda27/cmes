function [maxdens,times,positions] = getmaxdens(tinicial,tfinal,npoints)

interval = (tfinal-tinicial)/(npoints-1);

times     = zeros(npoints,1);
positions = zeros(npoints,1);
maxdens   = zeros(npoints,1);
previdx = 0;
for i = 1:npoints
    time = tinicial + interval*(i-1);
    
    [coords,dens,currtime,fileidx] = getdensline(time,'y',10,previdx);
    
    szcrds = max(size(coords));
    
    [maxdens(i),idpos] = max(dens(ceil(szcrds/2):szcrds));
    positions(i) = coords(idpos+ceil(szcrds/2));
    times(i) = currtime;
    previdx = max([0,fileidx-1]);
end