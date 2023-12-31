# test_index.jl

"""
Unit tests for index.jl.
"""

include("../src/index.jl")

using Test

v = ["AAA","AAA","AAA","AAA","TTT","TTT","TTT","TTT","CCC"]

@testset "Get probability distribution from a sequence window" begin
    @test index.get_dist(v) ≈ [4/9, 4/9, 1/9]
end


@testset "Index diversity of sequence windows in a matrix" begin
    w = ["AAA","TTT","CCC","GGG","AAT","ATT","TTC","TCC","CCG"]
    A = hcat(v, w)
    @test index.index_diversity(A, 0.5) ≈ [25/9, 9]
end
