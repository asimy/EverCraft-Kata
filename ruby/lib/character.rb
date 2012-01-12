require 'attack'
require 'standard_class'

class Character
  attr_accessor :name
  attr_reader :alignment, :experience
  attr_reader :armor_class

  attr_writer :experience       # TODO: Remove the need for this

  def self.ability(*names)
    names.each do |name|
      attr_accessor name
      define_method("#{name}_modifier") do
        value = send(name)
        (value - 10) / 2
      end
    end
  end

  ability :strength, :dexterity, :constitution, :wisdom, :intelligence, :charisma

  VALID_ALIGNMENTS = [
    :good, :neutral, :evil
  ]

  def initialize(name, klass=StandardClass)
    @name = name
    @base_armor_class = 10
    @total_damage = 0
    @strength = 10
    @dexterity = 10
    @constitution = 10
    @wisdom = 10
    @intelligence = 10
    @charisma = 10
    @experience = 0
    @class_strategy = klass.new(self)
    @alignment = :neutral
    yield(self) if block_given?
  end

  def level
    (experience / 1000) + 1
  end

  def set_level(level)
    @experience = (level-1) * 1000
  end

  def armor_class
    @base_armor_class + dexterity_modifier
  end

  def hit_points
    basic_health - @total_damage
  end

  def hit_points=(value)
    @total_damage = basic_health - value
  end

  def alignment=(value)
    raise ArgumentError, "Alignment (#{value}) must be :good, :neutral, or :evil" unless
      VALID_ALIGNMENTS.include?(value)
    @alignment = value
  end

  def attack_successful(roll)
    return true if roll > self.armor_class-1
    false
  end

  def attacking_with(die_value)
    Attack.new(self, die_value)
  end

  def attacked_by(attack)
    if attack.critical?
      take_damage(attack.critical_damage)
      attack.was_successful
    elsif successful?(attack.attack_value)
      take_damage(attack.normal_damage)
      attack.was_successful
    end
  end

  def dead?
    hit_points < 1
  end

  def critical_damage_multiplier
    @class_strategy.critical_damage_multiplier
  end

  def had_a_successful_attack
    @experience += 10
  end

  def attack_bonus
    @class_strategy.attack_bonus + level_bonus
  end

  private

  def level_bonus
    @class_strategy.level_bonus
  end

  def take_damage(damage)
    damage = 1 if damage <= 0
    @total_damage += damage
  end

  def successful?(die_value)
    die_value >= armor_class
  end

  def basic_health
    result = base_hit_points + constitution_modifier
    result = 1 if result < 1
    result
  end

  def base_hit_points
    level * @class_strategy.hits_per_level
  end
end
