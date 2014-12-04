function fingerprints = compute_fingerprints(data)

newfs = 5000;
frameSize = round(newfs*0.37);
frameAdvance = round(newfs*0.0116);
FPs = uint32(zeros(ceil((length(resample(data(1).signal,newfs,16000))-...
	frameSize)/frameAdvance)-1,length(data)));

% Compute all fingerprints for all songs, save them in FPs
for i=1:length(data)
	FPs(:,i) = fingerprinter([data(i).signal;...
		zeros(480000-length(data(i).signal),1)]);
	fprintf(1,'Fingerprinted %d songs\n',i);
end

% Arrange into blocks of 256 fingerprints
fingerprints = cell(length(data),ceil(size(FPs,1)/256));
for i=1:length(data)
	for j=1:ceil(size(FPs,1)/256)
		start = (j-1)*256+1;
		finish = (j)*256;
		if finish > size(FPs,1)
			finish = size(FPs,1);
			fingerprints{i,j} = [FPs(start:finish,i) ; ...
				                   zeros(256-length(start:finish),1)];
		else
			fingerprints{i,j} = FPs(start:finish,i);
		end
	end
end

end