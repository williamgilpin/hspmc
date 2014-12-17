close all;clear all;
N = 8^3; % total number of spheres (best 9^3 or more)
phi = .45; % volume fraction 
zeta = .005; % maximum displacement (best zeta=.005 for phi=.45 and zeta=.033 for phi=.2)
iter = 100; % number of passes to make over all particles (best 7000 or more)
coords=zeros(N,3); % list of the 3D positions of all particles
overlap=(6*phi/(pi*N))^(1/3); % set this to diam
% create initial, evenly-spaced lattice
numcell=(ceil(N^(1/3)));
cellside=1/numcell;
hh=linspace(-.5+.5*cellside,.5-.5*cellside,numcell);
for ii=1:N
    coords(ii,1)=hh(ceil(ii/ceil(N/numcell)));
    coords(ii,2)=hh(floor(mod(ii,ceil(N/numcell))/numcell)+1);
    coords(ii,3)=hh(mod(ii,numcell)+1);
end
% scatter3(coords(:,1),coords(:,2),coords(:,3),'filled');
% uncomment line above to show final lattice
%% metropolis section
accepts=0;
rejects=0;
for ii=1:iter
    for jj=1:N
        newcoords=coords;
        x=coords(jj,1);
        y=coords(jj,2);
        z=coords(jj,3);
        dx=2*zeta*rand-zeta;
        dy=2*zeta*rand-zeta;
        dz=2*zeta*rand-zeta;
        x=x+dx;
        y=y+dy;
        z=z+dz;
        if x>.5
            x=x-1;
        end
        if x<-.5
            x=x+1;
        end
        if y>.5
            y=y-1;
        end
        if y<-.5
            y=y+1;
        end
        if z>.5
            z=z-1;
        end
        if z<-.5
            z=z+1;
        end
        newcoords(jj,1)=x;
        newcoords(jj,2)=y;
        newcoords(jj,3)=z;
        if isoverlap2(newcoords, overlap, jj)==0 % only accept if there is no overlap
            coords(jj,1)=x;
            coords(jj,2)=y;
            coords(jj,3)=z;
            accepts=accepts+1;
        else rejects=rejects+1;
        end
    end
end
disp(accepts/(accepts+rejects));
% scatter3(coords(:,1),coords(:,2),coords(:,3),'filled'); 
% uncomment line above to show final lattice
%% compute pairwise distribution function
coos=buildlattice(coords);  % build an array of cubes to implement periodic BC
rmax=.5; % because of boundary condition design, g2(r) will not be accurate past here
nbins=180; % number of bins (tweak for smoothest curve)
totg2=zeros(nbins,1);
for jj=1:N % average over all particles
    g2=zeros(nbins,1);
    dists=sqrt(sum(bsxfun(@minus,coords(jj,:),coos).^2,2));
    dists(jj)=[]; % don't want to include tagged particle
    for ii=1:nbins
        isBin=((rmax*(ii-1)/nbins)<dists).*(dists<(ii/nbins)*rmax); %pairwise multiply is logical AND of binary vectors
        g2(ii)=sum(isBin)/(4*pi*(1/nbins)*(ii/nbins)^2*rmax^3);
    end
    totg2=totg2+g2;
end
totg2=totg2/N^2;
f1=figure();
plot(linspace(0,rmax/overlap,length(totg2)),totg2) % express in units of diameters
xlabel('r/D');
ylabel('g2(r)');
title(['packing fraction = ' num2str(phi)]);
print(f1,'g2hardsphere.png','-dpng',['-r',num2str(600)],'-opengl') % save an image
kk=[linspace(0,rmax/overlap,length(totg2))' totg2]; 
fileID = fopen('g2hardsphere.txt','w');   % save a list of values
fprintf(fileID,'%6s %12s\n','r/D','g2');
fprintf(fileID,'%6.6f %12.8f\n',kk');
fclose(fileID);
