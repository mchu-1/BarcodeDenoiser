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
    m = size(A)[2]
    W = zeros(m)
    for j in 1:m
        P = get_dist(A[:,j])
        W[j] = sum(p^q for p in P)^(1/(1-q))
    end
    
    return W
end

export get_dist
export index_diversity

end