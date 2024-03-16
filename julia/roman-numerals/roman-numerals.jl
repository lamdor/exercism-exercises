symbols = [
    (num="M", val=1000),
    (num="D", val=500),
    (num="C", val=100),
    (num="L", val=50),
    (num="X", val=10),
    (num="V", val=5),
    (num="I", val=1),
]

function _to_r(number)
    if number <= 0
        return ""
    end

    len = length(symbols)
    for (idx, sym) in enumerate(symbols)
        # the 9 case
        if idx <= len - 2 && idx % 2 == 1 # ignore those that are 5x
            nextnext = symbols[idx+2]
            if sym.val > number >= nextnext.val * 9
                return nextnext.num * sym.num * _to_r(number - nextnext.val * 9)
            end
        end

        # the simple case
        if number >= sym.val
            return sym.num * _to_r(number - sym.val)
        end

        # the 4 case
        if idx <= len - 1
            next = symbols[idx+1]
            if sym.val > number >= next.val * 4
                return next.num * sym.num * _to_r(number - next.val * 4)
            end
        end
    end
end

function to_roman(number)
    if number <= 0
        error("Must give number greater than zero")
    end

    return _to_r(number)
end
