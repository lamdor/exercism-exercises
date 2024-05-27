class DndCharacter
  def self.modifier(sum)
    (sum - 10) / 2
  end

  def initialize
    %i[strength dexterity constitution intelligence wisdom charisma].each do |ability|
      value = top_3_dice_of_4().sum
      define_singleton_method(ability) { value }
    end
  end

  def hitpoints
    10 + DndCharacter.modifier(constitution)
  end

  private
  def top_3_dice_of_4()
    Array.new(4)
         .map! { rand(6) + 1 }
         .sort!
         .last(3)
  end
end
