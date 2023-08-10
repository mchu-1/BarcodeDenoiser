# utils.jl

module utils

struct FileFormatError <: Exception
    msg::String
end

end