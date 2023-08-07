# plot.jl

"""
Plot diversity of sequence windows.
"""

using Plots

function plot_diversity(W::Vector{AbstractFloat}, out::String)
    x = [i for i in 1:length(Vector)]
    y = W

    plot(x,y)
    xlabel!("postiion")
    ylabel!("diversity")
    savefig(out*".png")
end

