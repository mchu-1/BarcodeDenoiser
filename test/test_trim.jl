# test_trim.jl

"""
Unit tests for trim.jl.
"""

import trim: get_sequences, generate_windows

using Test

@testset "Get sequences from file" begin
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
    @test get_sequences(mock_file) == ["AAAT", "GGGC"]

    defect_file = "f.bam"
    @test_throws FileFormatError get_sequences(defect_file)
end


@testset "Generate sequence windows" begin
    V = ["AAAAT", "GGGGC"]
    @test generate_windows(V, 3) == ["AAA" "AAA" "AAT"; "GGG" "GGG" "GGC"]
end