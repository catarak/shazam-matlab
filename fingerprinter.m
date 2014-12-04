function FPs = fingerprinter(clip)

newfs = 5000;

frameSize = round(newfs*0.37);
frameAdvance = round(newfs*0.0116);
hamm = hamming(frameSize);

clip = resample(clip, newfs,16000);

start=1;
finish = frameSize;

E = zeros(ceil((length(clip)-frameSize)/frameAdvance),33);
Eind=1;

F = zeros(max(size(E)),32);

FPs = uint32(zeros(size(E,1)-1,1));

while finish <= length(clip)
	freqdom = abs(fft(clip(start:finish).*hamm));
	meldom = 2595*log10(freqdom(111:740)/700+1);
	for j=1:33
		E(Eind,j) = meldom((j-1)*19+1:j*19)'*meldom((j-1)*19+1:j*19);
	end
	Eind=Eind+1;
	
	start = start+frameAdvance;
	finish = finish+frameAdvance;
end

for n=2:max(length(F))
	for m = 1:32
		if ((E(n,m)-E(n,m+1)) - (E(n-1,m)-E(n-1,m+1))) > 0
			F(n,m) = 1;
		else
			F(n,m) = 0;
		end
	end
end

for n=1:size(F,1)-1
	FPs(n) = vec2uint32(F(n+1,:));
end

end