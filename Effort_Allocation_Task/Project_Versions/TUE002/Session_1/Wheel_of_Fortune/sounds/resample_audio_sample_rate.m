%%resample_audio_sample_rate

[y,Fs] = audioread('lose_toobig.wav');

audiowrite('lose_better.wav',y,48000);

%new_lose.wav = resample('lose_toobig.wav', 44100, 48000);