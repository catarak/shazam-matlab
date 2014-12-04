function num = vec2uint32(vec)
num = uint32(0);
for i=1:32
	if vec(i)==1
		num = num+1;
	end
	if i~=1
		num = bitshift(num,1);
	end
end