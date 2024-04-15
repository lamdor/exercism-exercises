const letter_scores = [
    ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'] => 1,
    ['D', 'G'] => 2,
    ['B', 'C', 'M', 'P'] => 3,
    ['F', 'H', 'V', 'W', 'Y'] => 4,
    ['K'] => 5,
    ['J', 'X'] => 8,
    ['Q', 'Z'] => 10,
]

const scores_for_individual_letters = Dict(
    letter => score
    for (letters, score) in letter_scores
    for letter in letters
)

function score_for_letter(letter::Char)
    get(scores_for_individual_letters, uppercase(letter), 0)
end

function score(str)
    isempty(str) && return 0

    sum(score_for_letter, str)
end
