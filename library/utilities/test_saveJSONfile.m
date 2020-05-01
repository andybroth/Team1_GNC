clear all;
rng(1)

data.A = randn(4)
data.B = randn(5)
saveJSONfile(data, 'out.json');
