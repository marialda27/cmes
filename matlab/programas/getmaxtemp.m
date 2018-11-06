function maxtemp = getmaxtemp(time)


[filename,nxb,nyb,nzb,ndim,xmin,xmax,ymin,ymax,zmin,zmax] = geth5data;


for i = 0:9999
    ichar = num2str(i,'%4i')
    if      (i > 999); currfile = strcat(filename,ichar);
    elseif  (i > 99); currfile = strcat(filename,'0',ichar);
    elseif  (i > 9); currfile = strcat(filename,'00',ichar);
    else   currfile = strcat(filename,'000',ichar);
    end
    
    if exist(currfile,'file')
        rlsclrs =  h5read(currfile,'/real scalars');
        currtime = rlsclrs.value(1);
        
        if (currtime >= time)
            intgrsclrs = h5read(currfile,'/integer scalars');
            intgrprmtrs = h5read(currfile,'/integer runtime parameters');
            boundbox = h5read(currfile,'/bounding box'); % Límites físicos de los bloques            

            
            dimarrays = 1;
            
            maxtemp = 0;
            
            if (max(size(intgrprmtrs.value)) < 70) % Grilla uniforme
                
                dum = h5read(currfile,'/temp');
                
                maxdens = max(dum);
                
            else
                nblocks = intgrsclrs.value(5);  % Número total de bloques
                reflevel = h5read(currfile,'/refine level'); % nivel de refinamiento de cada bloque            
                        
                dum = h5read(currfile,'/temp');
                for nb = 1:nblocks-1
                    if ((reflevel(nb) >= reflevel(nb+1)))
                        for ix = 1:nxb
                            for iy = 1:nyb
                                for iz = 1:nzb
                                    maxtemp = max([maxtemp,dum(ix,iy,iz,nb)]);
                                end
                            end
                        end
                    end
                       
                end
            end
            break
        end
    else
        break
    end
end

    
