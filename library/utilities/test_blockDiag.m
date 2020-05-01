clear all;
close all;
rng(1);

A_block = randn(2)
A1 = blockDiag(A_block,3)
A2 = blockDiag(A_block,4)

B_block = randn(2,3)
B1 = blockDiag(B_block,2)
B2 = blockDiag(B_block,3)


