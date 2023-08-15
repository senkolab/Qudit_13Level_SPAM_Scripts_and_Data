function Error = Error_fun(P,x)
Scale = P(1);
Offset = P(2);

%Pi_pulse_error = (1/2).*(1-exp(-Scale.*x));
Pi_pulse_error = Scale.*x;

Error = Pi_pulse_error./(Pi_pulse_error+(1-Pi_pulse_error).^2)+Offset;