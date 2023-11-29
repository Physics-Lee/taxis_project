function acf = dot_product_autocorr(unit_vectors, max_lag)
acf = zeros(1, max_lag + 1);
n = size(unit_vectors, 2);

for lag = 0:max_lag
    total_dot_product = 0;
    for t = 1:n-lag
        total_dot_product = total_dot_product + dot(unit_vectors(:, t), unit_vectors(:, t + lag));
    end
    acf(lag + 1) = total_dot_product / (n - lag);
end

end