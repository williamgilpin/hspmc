function isoverlap = isoverlap(coords, overlap)
% takes an list of 3D coordinates and minimum requries separation and returns whether or not two spheres
% overlap
% need to take into account wraparound overlap
D=pdist(coords); % list of all pairwise distances
isoverlap=any(D<overlap);
end