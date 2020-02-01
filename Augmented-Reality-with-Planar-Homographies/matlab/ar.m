% Q3.3.1
source = loadVid('../data/ar_source.mov');
dest = loadVid('../data/book.mov');
cover = imread('../data/cv_cover.jpg');

size_source = size(source,2);
size_dest = size(dest,2);
[m, n] = size(cover);
ar_video = dest;

for i = 1:size_dest
    [locs1, locs2] = matchPics(cover, dest(i).cdata);
    [H2to1, ~] = computeH_ransac(locs1, locs2);
    if i <= size_source
        source_cut = source(i).cdata(5:350,175:460,:);
        source_scaled = imresize(source_cut, [m n]);
    else
        source_scaled = zeros(m,n,3);
    end
    ar_video(i).cdata = compositeH(inv(H2to1), source_scaled, dest(i).cdata);
end

v = VideoWriter('../results/ar.avi');
open(v);
writeVideo(v,ar_video);
close(v);