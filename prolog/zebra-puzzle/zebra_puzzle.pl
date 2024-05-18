% Not totally my solution, but I did learn a lot of prolog along the way.
% I originally started with a bunch of rules with multiple heads. 
% The problem with that is that they all OR and we want them as multiple constraints. 
% It didn't take until I looked at the solutions to get that.
% However, I did come to love Prolog along the way.

% house(who, color, animal, drink, smokes)

water_drinker(Resident) :-
  houses(Houses),
  member(house(Resident, _, _, water, _), Houses).

zebra_owner(Resident) :-
  houses(Houses),
  member(house(Resident, _, zebra, _, _), Houses).

houses(Houses) :-
  % There are five houses.
  length(Houses, 5),
  
  % The Englishman lives in the red house.
  member(house(englishman, red, _, _, _), Houses),

  % The Spaniard owns the dog.
  member(house(spaniard, _, dog, _, _), Houses),

  % Coffee is drunk in the green house.
  member(house(_, green, _, coffee, _), Houses),

  % The Ukrainian drinks tea.
  member(house(ukranian, _, _, tea, _), Houses),

  % The green house is immediately to the right of the ivory house.
  right_of(
    Houses, 
    house(_, ivory, _, _, _), 
    house(_, green, _, _, _)
  ),

  % The Old Gold smoker owns snails.
  member(house(_, _, snails, _, old_gold), Houses),

  % Kools are smoked in the yellow house.
  member(house(_, yellow, _, _, kools), Houses),

  % Milk is drunk in the middle house.
  nth1(3, Houses, house(_, _, _, milk, _)),

  % The Norwegian lives in the first house.
  nth1(1, Houses, house(norwegian, _, _, _, _)),

  % The man who smokes Chesterfields lives in the house next to the man with the fox.
  next_to(
    Houses, 
    house(_, _, _, _, chesterfields),
    house(_, _, fox, _, _)
  ),

  % Kools are smoked in the house next to the house where the horse is kept.
  next_to(
    Houses, 
    house(_, _, _, _, kools),
    house(_, _, horse, _, _)
  ),

  % The Lucky Strike smoker drinks orange juice.
  member(house(_, _, _, orange_juice, lucky_strike), Houses),

  % The Japanese smokes Parliaments.
  member(house(japanese, _, _, _, lucky_strike), Houses),

  % The Norwegian lives next to the blue house.
  next_to(
    Houses, 
    house(norwegian, _, _, _, _),
    house(_, blue, _, _, _)
  ).

right_of(Houses, House1, House2) :-
  nth1(FirstIdx, Houses, House1),
  nth1(SecondIdx, Houses, House2),
  succ(FirstIdx, SecondIdx).

next_to(Houses, House1, House2) :-
  nth1(FirstIdx, Houses, House1),
  nth1(SecondIdx, Houses, House2),
  abs(FirstIdx - SecondIdx) =:= 1.
