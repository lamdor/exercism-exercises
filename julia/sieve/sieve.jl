function sieve(limit)
    marked = Set{Int}([])

    function is_not_marked_then_mark_multiples(n)
        n in marked && return false

        foreach(i -> push!(marked, i), ((2n):n:limit))

        return true
    end

    filter(is_not_marked_then_mark_multiples, (2:limit))
end
