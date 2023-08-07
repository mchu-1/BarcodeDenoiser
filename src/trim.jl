# trim.jl

"""
Trim sequencing data into windows of fixed size.
"""

module trim

struct FileFormatError <: Exception
    msg::String
end

function get_sequences(file, l, r::String)
    """
    Get sequences from FASTQ file.
    """
    if split(file, ".")[end] != "fastq"
        throw(FileFormatError("File must be in FASTQ format."))
    end

    # Read in FASTA
    V = readlines(file)
    V = filter(!isempty, V)

    # Get sequences
    V = V[2:end][startswith.(V[begin:end-1], "@")]

    return V
end


function trim_sequence(v, l, r::String)
    """
    Trim sequence using left and right patterns.
    """
    i = findfirst(l, seq)[0]
    j = findfirst(r, seq)[1]
    if nothing in [i, j]
        return nothing
    else
        return v[i:j]
    end
end


function generate_windows(V::Vector{String}, k::AbstractInt)
    """
    Generate matrix of k-mer sequence windows.
    """                 
    # Initiate string matrix
    m = length(V[1])
    n = length(V)-k+1
    A = fill("", m, n)     

    # Generate windows matrix
    A = [V[i][j:j+k] for i in 1:n for j in 1:m]

    return A
end

export get_sequences
export trim_sequence
export generate_windows

end