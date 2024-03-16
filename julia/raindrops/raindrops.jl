const factorsounds = [
    (3, "Pling"),
    (5, "Plang"),
    (7, "Plong"),
]

function raindrops(number)

    is_factor(factorsound) = rem(number, factorsound[1]) == 0
    sound(factorsound) = factorsound[2]
    
    sounds = factorsounds |> filter(is_factor) .|> sound

    if isempty(sounds)
        return string(number)
    else
        return join(sounds)
    end

end
