# index.jl

"""
Index diversity of barcode sequencing data.
"""

module index

using StatsBase

function get_dist(a::Vector{String})
    """
    Get probability distribution of a vector.
    """
    d = countmap(a)
    P = [d[k]/sum(values(d)) for k in keys(d)] 

    return P
end


function index_diversity(A::Matrix{String}, q::AbstractFloat)
    """
    Index diversity of sequence windows.
    """
    # Compose D and P over the columns of A
    W = ((P -> sum(p^q for p in P)^(1/(1-q))) ∘ (a -> get_dist(a))).(eachcol(A))

    return W
end

export get_dist
export index_diversity

end