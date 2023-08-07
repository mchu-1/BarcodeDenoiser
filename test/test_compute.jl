# test_compute.jl

"""
Unit tests for compute.jl.
"""

include("../src/compute.jl")

using Test

W = [1, 2, 25/9, 25/9, 3]
n, s, t = 2, 25/9, 25/18

@testset "Compute noise from diversity vector" begin
    @test compute.compute_noise(W, 3, 2) == n
end

@testset "Compute barcode diversity" begin
    @test compute.compute_apparent_diversity(W, 3) ≈ s
    @test compute.compute_true_diversity(n, s) ≈ t
end