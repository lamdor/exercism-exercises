"""
    ispangram(input)

Return `true` if `input` contains every alphabetic character (case insensitive).

"""
function ispangram(input)
    function only_push_letters!(set, c)
        if isletter(c)
            push!(set, c)
        else
            set
        end
    end

    distinct = mapreduce(lowercase, only_push_letters!, input, init=Set{Char}())
    return length(distinct) == 26
end

