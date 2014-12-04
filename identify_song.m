function song_id = identify_song(clip, fingerprints, data)

FPs = fingerprinter(clip);

% so now we have fingerprints and FPs, time to do some searching
% could use a speed up right here...
hits = zeros(size(fingerprints));
for i=1:size(fingerprints,1)
	for j=1:size(fingerprints,2)
		for k=1:length(FPs)
			if find(fingerprints{i,j}==FPs(k))
				hits(i,j) = hits(i,j)+1;
			end
		end
	end
end

[~,song_id] = max(max(hits,[],2));

fprintf(1,'Clip was identified as a part of "%s"\n',data(song_id).title);

end