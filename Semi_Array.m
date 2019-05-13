num_array = 2*4;
f = 10e9;
c = 3e8;
wavelength = c/f;
margin = wavelength/2;
theta_signal = 0;

weight_leftSubArray = exp(-1j*2*pi*margin*(0: num_array/2 - 1)'*sind(theta_signal)/wavelength);
weight_rightSubArray = exp(-1j*2*pi*margin*(num_array/2: num_array - 1)'*sind(theta_signal)/wavelength);

theta = (-90: 0.1: 90)';
pattern_left = zeros(length(theta), 1);
pattern_right = zeros(length(theta), 1);
for n = 1: length(theta)
    steerVec_left = exp(-1j*2*pi*margin*(0: num_array/2 - 1)'*sind(theta(n))/wavelength);
    steerVec_right = exp(-1j*2*pi*margin*(num_array/2: num_array - 1)'*sind(theta(n))/wavelength);
    pattern_left(n) = weight_leftSubArray'*steerVec_left;
    pattern_right(n) = weight_rightSubArray'*steerVec_right;
end
sum_beam = pattern_left + pattern_right;
difference_beam = pattern_right - pattern_left;
plot(theta, 20*log10(abs(sum_beam)/max(abs(sum_beam))))
hold on
plot(theta, 20*log10(abs(difference_beam)/max(abs(difference_beam))))
hold off
legend('sum beam', 'difference beam')
set(gca, 'XTICK', -80: 20: 80)
grid on
xlabel('angle/degree')
ylabel('spectrum/dB')
title('Pattern')