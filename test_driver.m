clearvars -except data fp;
close all;
clc;

if ~exist('data','var')
	load proj2data.mat
end

if ~exist('fp','var')
	if exist('fp.mat','file')
		load fp.mat;
	else
		fp = compute_fingerprints(data);
		save('fp.mat','fp');
	end
end

matches=zeros(1,4);
tries = zeros(1,4);
avgtime = 0;
numTests = 200;

dB = [40 45 50 55];

for k=1:numTests
		
	Rsong = round(rand*100);
	Rclip = round(rand*(length(data(1).signal)-16000*3));
	if(Rsong==0)
		Rsong=1;
	end
	if(Rclip==0)
		Rclip=1;
	elseif Rclip > 382196
		Rclip = 382196;
	end
	clip = data(Rsong).signal(Rclip:Rclip+16000*3-1);

	if k > 150
		dBind = 4;
	elseif k > 100
		dBind = 3;
	elseif k > 50
		dBind = 2;
	else
		dBind = 1;
	end
	
	clip = awgn(clip,dB(dBind));
	
	tic;
	ID = identify_song(clip, fp, data);
	tElapsed=toc;

	if (ID == Rsong)
		matches(dBind) = matches(dBind)+1;
	end
	tries(dBind) = tries(dBind)+1;
	
%	fprintf(1,'%d for %d\n',matches,k);
	avgtime = avgtime + tElapsed;
end
avgtime = avgtime/numTests;

%fprintf(1,'Percent accuracy: %f\nAvg search time: %5.4d seconds\n',...
%	100*matches/numTests, avgtime);
fprintf('done');