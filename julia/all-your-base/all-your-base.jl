function convert_to_int(digits, base)
    base > 1 || throw(DomainError("base $(base) must be greater than 1"))
    len = length(digits)

    function sum_iterator((left_index, n))
        n >= 0 || throw(DomainError("digit $(n) must be >= 0"))
        n < base || throw(DomainError("digit $(n) must be < base $(base)"))
        base^(len - left_index) * n
    end

    sum(sum_iterator, enumerate(digits); init=0)
end

function convert_to_base(number, base)
    base > 1 || throw(DomainError("base $(base) must be greater than 1"))
    number >= 0 || throw(DomainError("number $(number) must be >= 0"))

    number == 0 && return [0]

    digits = Int[]

    power = 0
    while number > 0
        factor = base^power
        digit = div(rem(number, factor * base), factor)

        number -= digit * factor
        power += 1

        pushfirst!(digits, digit)
    end

    return digits
end


function all_your_base(digits, base_in, base_out)
    number = convert_to_int(digits, base_in)
    convert_to_base(number, base_out)
end
