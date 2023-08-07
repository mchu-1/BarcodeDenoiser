# compute.jl

"""
Compute noise and barcode diversity.
"""

module compute

using Statistics

function compute_noise(W::Vector{AbstractFloat}, b,k::AbstractInt)
    """
    Compute noise from diversity vector.
    """
    N = mean(vcat(W[begin:b-1], W[b+k+1:end]))

    return N

end


function compute_apparent_diversity(W::Vector{AbstractFloat}, b::AbstractInt)
    """
    Compute apparent barcode diversity.
    """
    S = W[b]

    return S
end


function compute_true_diversity(N, S::AbstractFloat)
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
