function lattice = buildlattice(coords)
% this function takes a list of coordinates in the unit cube and creates
% copies of the cube around the center cube. coords is a 3xN array
% containing hte x,y,z coordinates of N particles within a unit cell. 
% lattice is a 3x(27N) array containing 27 duplicates of the coordinates
% arranged in a lattice.
coos=coords;
for kk=1:3
    newco1=coords;
    newco2=coords;
    newco1(:,kk)=coords(:,kk)+1;
    newco2(:,kk)=coords(:,kk)-1;
    coos=[coos; newco1;newco2];
    for jj=1:3
        if (jj>kk)
            newco11=newco1;
            newco12=newco1;
            newco21=newco2;
            newco22=newco2;
            newco11(:,jj)=newco1(:,jj)+1;
            newco12(:,jj)=newco1(:,jj)-1;
            newco21(:,jj)=newco2(:,jj)+1;
            newco22(:,jj)=newco2(:,jj)-1;
            coos=[coos; newco11; newco12; newco21; newco22];
        end
    end
end
newco=coords;
newco(:,1)=newco(:,1)+1;
newco(:,2)=newco(:,2)+1;
newco(:,3)=newco(:,3)+1;
coos=[coos; newco];
newco=coords;
newco(:,1)=newco(:,1)+1;
newco(:,2)=newco(:,2)+1;
newco(:,3)=newco(:,3)-1;
coos=[coos; newco];
newco=coords;
newco(:,1)=newco(:,1)+1;
newco(:,2)=newco(:,2)-1;
newco(:,3)=newco(:,3)+1;
coos=[coos; newco];
newco=coords;
newco(:,1)=newco(:,1)+1;
newco(:,2)=newco(:,2)-1;
newco(:,3)=newco(:,3)-1;
coos=[coos; newco];
newco=coords;
newco(:,1)=newco(:,1)-1;
newco(:,2)=newco(:,2)+1;
newco(:,3)=newco(:,3)+1;
coos=[coos; newco];
newco=coords;
newco(:,1)=newco(:,1)-1;
newco(:,2)=newco(:,2)+1;
newco(:,3)=newco(:,3)-1;
coos=[coos; newco];
newco=coords;
newco(:,1)=newco(:,1)-1;
newco(:,2)=newco(:,2)-1;
newco(:,3)=newco(:,3)+1;
coos=[coos; newco];
newco=coords;
newco(:,1)=newco(:,1)-1;
newco(:,2)=newco(:,2)-1;
newco(:,3)=newco(:,3)-1;
coos=[coos; newco];
lattice=coos;