function c_hat = hat(c)

c_hat = [0 -c(3) c(2);c(3) 0 -c(1);-c(2) c(1) 0];
