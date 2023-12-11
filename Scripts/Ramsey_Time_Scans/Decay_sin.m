function y = Decay_sin(P,x)
Amplitude = P(1);
Pi_time = P(2);
T2 = P(3);
phase = P(4);
%offset = P(5);

y = (Amplitude/2).*(sin(pi.*x./(Pi_time) + phase)).*exp(-x./T2)+Amplitude/2;