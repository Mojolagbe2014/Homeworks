function [y] = Gaussian(a, t0, sig, t)

y = a.*exp(-((t-t0)./sig).^2);