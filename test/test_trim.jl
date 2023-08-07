# test_trim.jl

"""
Unit tests for trim.jl.
"""

include("../src/trim.jl")

using Test

@testset "Get sequences from file" begin
    defect_file = "f.bam"
    @test_throws trim.FileFormatError trim.check_format(defect_file)

    mock_file = IOBuffer("""
        @SEQ_1
        AAAAT
        +
        !''*(
        @SEQ_2
        GGGGC
        +
        (((**
        """)
    @test trim.get_sequences(mock_file) == ["AAAAT", "GGGGC"]
end


@testset "Trim sequence" begin
    seq = "NNNACTGMMM"
    trimmed_seq = "ACTG"
    @test trim.trim_sequence(seq, "NNN", "MMM") == trimmed_seq
    @test trim.trim_sequence(seq, "PPP", "MMM") ===  nothing
end


@testset "Generate sequence windows" begin
    V = ["AAAAT", "GGGGC"]
    @test trim.generate_windows(V, 3) == ["AAA" "AAA" "AAT"; "GGG" "GGG" "GGC"]
end