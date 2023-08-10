# plot.jl

"""
Graph diversity of sequence windows.
"""
module graph

using Plots

include("utils.jl")

function plot_diversity(W::Vector{Float64}, out::String)
    """
    Plot sequence diversity.
    """
    if split(out, ".")[end] != "png"
        throw(utils.FileFormatError("Output file must be in PNG format."))
    end

    x = [i for i in 1:length(W)]
    plot(x, W, legend=false, grid=false)

    xlims!(0, length(W)+1)
    ylims!(0, ceil(maximum(W)+1))
    
    xlabel!("position")
    ylabel!("diversity")
    savefig(out)
end

export plot_diversity

end