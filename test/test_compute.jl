# test_compute.jl

"""
Unit tests for compute.jl.
"""

import compute

using Test

W = [1, 2, 25/9, 25/9, 3]
n, s, t = 2, 25/9, 7/9

@testset "Compute noise from diversity vector" begin
    @test compute.compute_noise(W, b=3, k=2) == n
end

@testset "Compute barcode diversity" begin
    @test compute.compute_apparent_diversity(W, b=3) ≈ s
    @test compute.compute_barcode_diversity(n, s) ≈ t
end