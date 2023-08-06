# index.jl

module index
using StatsBase

"""
Index diversity of barcode sequencing data.
"""

struct TrimmingError <: Exception
    msg::String
end

function generate_windows(file::String, k::Int)
    """
    Generate matrix of k-mer sequence windows from file.
    """
    # Read in sequences
    V = readlines(file)
    V = filter(!isempty, V)
    if length(Set([length(v) for v in V])) != 1
        throw(TrimmingError("Sequences have not been trimmed to equal length."))
    end

    # Generate windows matrix
    m = length(v[1])
    n = length(V)-k+1
    A = [V[i][j:j+k] for i in 1:n for j in 1:m]

    return A
end
    

function get_dist(a::Vector{String})
    """
    Get probability distribution of a vector.
    """
    d = countmap(a)
    P = [d[k]/sum(values(d)) for k in keys(d)] 

    return P
end


function index_diversity(A::Matrix{String}, q::Float64)
    """
    Index diversity of sequence windows.
    """
    # Compose D and P over the columns of A
    W = ((P -> sum(p^q for p in P)^(1/(1-q))) ∘ (a -> get_dist(a))).(eachcol(A))

    return W
end

export generate_windows
export get_dist
export index_diversity

end