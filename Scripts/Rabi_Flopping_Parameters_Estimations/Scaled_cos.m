function y = Scaled_cos(P,x)
Amplitude = P(1);
Pi_time = P(2);
Peak = P(3);
Offset = P(4);

y = Amplitude.*(cos((pi/2).*(x-Peak)./Pi_time)).^2+Offset;