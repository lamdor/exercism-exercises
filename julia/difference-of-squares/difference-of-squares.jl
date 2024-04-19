# from https://brilliant.org/wiki/sum-of-n-n2-or-n3/

"Square the sum of the first `n` positive integers"
function square_of_sum(n)
    # sum(1:n) already uses Gauss's formula
    # div(n * (n + 1), 2)^2
    sum(1:n)^2
end

"Sum the squares of the first `n` positive integers"
function sum_of_squares(n)
    div(n * (n + 1) * (2n + 1), 6)
end

"Subtract the sum of squares from square of the sum of the first `n` positive ints"
function difference(n)
    abs(sum_of_squares(n) - square_of_sum(n))
end
