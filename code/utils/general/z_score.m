function y = z_score(x)

y = (x - mean(x,'omitnan'))./std(x,'omitnan');

end