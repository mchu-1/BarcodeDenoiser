# BarcodeDenoiser.jl

"""
Statistically denoise barcode sequencing data.
"""

include("trim.jl")
include("index.jl")
include("compute.jl")
include("graph.jl")

using ArgParse
using YAML
using Logging

function parse_cmd()
    s = ArgParseSettings()
    @add_arg_table begin
        "--input"
            help = "Input sequencing file (FASTQ)."
            arg_type = String
        "--config"
            help = "Config file (YAML)."
            arg_type = String
        "--output"
            help = "Output directory."
            arg_type = String
    end

    return parse_args(s)
end


function denoise_data(file, config, out::String)
    """
    Denoise barcode sequencing data.
    """
    settings = YAML.load_file(config)
    @info "Read settings from $config"
    
    trim.check_format(file)
    @info "Checked format of $file."

    file = open(file, "r")
    V = trim.get_sequences(file)
    @info "Read sequences from $file."

    l, r = settings["left"], settings["right"]
    V = [trim_sequence(v, l, r) for v in V]
    V = V[V.!=nothing]
    @info "Trimmed sequences between '$l' and '$r'."

    k = settings["k"]
    A = trim.generate_windows(V, k)
    @info "Generated $k-mer windows."
    
    q = settings["q"]
    W = index.index_diversity(A, q)
    @info "Indexed diversity using the Hill number of order $q."
    
    b = settings["b"]
    N = compute.compute_noise(W, b, k)
    @info "Noise = $N."
    
    S = compute.compute_apparent_diversity(W, b)
    @info "Apparent barcode diversity = $S"

    T = compute.compute_true_diversity(N, S)
    @info "True barcode diversity estimated at $T."

    plot.plot_diversity(W, out)
    @info "Plot diversity and saved to $out."
    @info "Completed successfully for $file."

end

args = parse_cmd()
file, config, out = args["input"], args["config"], args["out"]
denoise_data(file, config, out)