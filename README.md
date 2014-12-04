#Shazam in MATLAB

This was the final project for an audio and speech processing class I took in college. The goal was to create a version of Shazam in MATLAB, using techniques similar to the technology behind Shazam.

The first step was to extract a series of fingerprints from a few songs and amass a corpus of data. Each fingerprint is a spectrogram taken from about a two second window. The fingerprint is then quantized, meaning that if the amplitude at a specific point is above a threshold value, it is assigned a "1", and if below that threshold, a "0". 

After analyzing all of the songs, we then could identify song clips. The clips were also windowed and spectrograms extracted, and then compared to our corpus of data. Unfortunately, our comparisons were brute force rather then using a Hash Map since using Java Hash Maps in MATLAB turns out to be quite slow. 

We also discovered that above 20 dB of AWGS (additive white Gaussian noise) our accuracy dropped greatly. 