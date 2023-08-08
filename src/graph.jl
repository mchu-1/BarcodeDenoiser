# plot.jl

"""
Graph diversity of sequence windows.
"""
module graph

using Plots

function plot_diversity(W::Vector{Float64}, out::String)
    """
    Plot sequence diversity.
    """
    x = [i for i in 1:length(W)]
    plot(x, W, legend=false, grid=false)

    xlims!(0, length(W)+1)
    ylims!(0, ceil(maximum(W)+1))
    
    xlabel!("position")
    ylabel!("diversity")
    savefig(out*".png")
end

export plot_diversity

end