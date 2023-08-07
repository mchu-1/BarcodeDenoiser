# test_compute.jl

"""
Unit tests for compute.jl.
"""

import compute: compute_noise, compute_apparent_diversity, compute_true_diversity

using Test

W = [1, 2, 25/9, 25/9, 3]
n, s, t = 2, 25/9, 7/9

@testset "Compute noise from diversity vector" begin
    @test compute_noise(W, b=3, k=2) == n
end

@testset "Compute barcode diversity" begin
    @test compute_apparent_diversity(W, b=3) ≈ s
    @test compute_barcode_diversity(n, s) ≈ t
end