function luhn(str::String)
    sum = 0
    i = 0

    for c in Iterators.reverse(str)
        isdigit(c) || c == ' ' || return false

        if c != ' '
            i += 1

            d = parse(Int, c)

            if i % 2 == 0
                if d > 4
                    d = 2d - 9
                else
                    d = 2d
                end
            end

            sum += d
        end
    end

    return i > 1 && sum % 10 == 0
end
