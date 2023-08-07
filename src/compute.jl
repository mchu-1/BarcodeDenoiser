# compute.jl

"""
Compute noise and barcode diversity.
"""

module compute

using Statistics

function compute_noise(W::Vector{Float64}, b,k::Int)
    """
    Compute noise from diversity vector.
    """
    N = mean(vcat(W[begin:b-1], W[b+k:end]))

    return N

end


function compute_apparent_diversity(W::Vector{Float64}, b::Int64)
    """
    Compute apparent barcode diversity.
    """
    S = W[b]

    return S
end


function compute_true_diversity(N, S::Float64)
    """
    Compute true barcode diversity by decomposition.
    """
    T = S/N

    return T
end

export compute_noise
export compute_apparent_diversity
export compute_true_diversity

end
