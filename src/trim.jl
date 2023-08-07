# trim.jl

"""
Trim sequencing data into windows of fixed size.
"""
module trim

struct FileFormatError <: Exception
    msg::String
end

function check_format(file::String)
    if split(file, ".")[end] != "fastq"
        throw(FileFormatError("File must be in FASTQ format."))
    end
end


function get_sequences(file::IO)
    """
    Get sequences from FASTQ file.
    """
    # Read in FASTQ
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
    i = findfirst(l, v)
    j = findfirst(r, v)
    if nothing in [i, j]
        return nothing
    else
        i, j = i[end]+1, j[begin]-1
        return v[i:j]
    end
end


function generate_windows(V::Vector{String}, k::Int)
    """
    Generate matrix of k-mer sequence windows.
    """                 
    # Initiate string matrix
    n = length(V)
    m = length(V[1])-k+1
    A = fill("", n, m)     

    # Generate windows matrix
    for i in 1:n
        for j in 1:m
            A[i,j] = V[i][j:j+k-1]
        end
    end

    return A
end

export get_sequences
export trim_sequence
export generate_windows

end