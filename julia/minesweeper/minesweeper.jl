annotate(::Vector{Any}) = []

function annotate(minefield::Vector{String})
    is_mine(c::Char) = c == '*'
    mines_count_char(i::Int) =
        if i == 0
            ' '
        else
            Char('0' + i)
        end

    for (i, row) in enumerate(minefield)
        new_row = Vector{Char}(undef, length(row))

        for (j, cell) in enumerate(row)
            new_row[j] =
                if is_mine(cell)
                    '*'
                else
                    count = count_neighborhood(is_mine, minefield, i, j)
                    mines_count_char(count)
                end
        end

        minefield[i] = String(new_row)
    end

    return minefield
end

function count_neighborhood(f::Function, strs::Vector{String}, i::Int, j::Int)
    rows = length(strs)

    first_len = if rows > 0
        length(strs[1])
    else
        0
    end

    first_row = max(i - 1, 1)
    first_column = max(j - 1, 1)
    last_row = min(i + 1, rows)
    last_column = min(j + 1, first_len)

    sum(strs[first_row:last_row]) do str
        count(f, Vector{Char}(str[first_column:last_column]))
    end
end
