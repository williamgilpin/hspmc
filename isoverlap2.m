function isoverlap = isoverlap2(coords, overlap, index)
% takes an list of 3D coordinates and minimum requries separation and returns whether or not two spheres
% overlap
coos=buildlattice(coords);
coos(index,:)=[]; % because don't want to find distance to itself
dists=sqrt(sum(bsxfun(@minus,coords(index,:),coos).^2,2));
isoverlap=any(dists<overlap);
end