matches = [2	0	1	1	1	1	0	4	12	29	40	45	49	48	50	49]./50;
plot((-20:5:55),matches);
title('Accuracy vs. Added White Noise');
xlabel('Added White Gaussian Noise (dB)');
ylabel('Accuracy, 50 samples');
grid on;