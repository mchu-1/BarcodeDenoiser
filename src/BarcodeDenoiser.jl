# BarcodeDenoiser.jl

"""
Statistically denoise barcode sequencing data.
"""

import trim, index, compute, plot

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

# TODO: Refactor out
# TODO: Import vs include
# TODO: Refactor config file

function denoise_data(file, config, out::String)
    """
    Denoise barcode sequencing data.
    """
    settings = YAML.load_file(config)
    @info "Read settings from $config"
    
    V = trim.get_sequences(file)
    @info "Read sequences from $file."

    k = settings["k"]
    A = trim.generate_windows(V)
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