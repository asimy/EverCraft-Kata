require 'attack'
require 'standard_class'
require 'integer_extensions'

class Character
  attr_accessor :name
  attr_reader :alignment, :experience

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

  VALID_ALIGNMENTS = [ :good, :neutral, :evil ]

  def initialize(name, options={})
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
    @class_strategy = :unspecified
    @alignment = :neutral
    klass = options.delete(:class) || StandardClass
    @class_strategy = klass.new(self)
    # race = options.delete(:race) || HumanRace
    # @race = race.new(self)
    fail ArgumentError, "No block allowed on initializer" if block_given?
    options.each do |field, value|
      set(field, value)
    end
  end

  def level
    (experience / 1000) + 1
  end

  def set_level(level)
    @experience = (level-1) * 1000
  end

  def base_armor_class
    @base_armor_class
  end

  def armor_class
    @base_armor_class + @class_strategy.armor_bonus
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

  def attacks(defender, die_value)
    Attack.new(self, defender, die_value).invoke
  end

  def base_damage(defender)
    @class_strategy.base_damage(defender)
  end

  def dead?
    hit_points < 1
  end

  def critical_damage_multiplier(defender)
    @class_strategy.critical_damage_multiplier(defender)
  end

  def normal_damage_multiplier_for(defender)
    @class_strategy.normal_damage_multiplier_for(defender)
  end

  def take_damage(damage)
    @total_damage += damage.but_at_least(1)
  end

  def gains_experience(xp)
    @experience += xp
  end

  def attack_bonus(defender)
    @class_strategy.attack_bonus(defender) + level_bonus
  end

  def choose_defenders_armor(base_armor, normal_armor)
    @class_strategy.choose_defenders_armor(base_armor, normal_armor)
  end

  private

  def set(field, value)
    if field == :level
      set_level(value)
    elsif respond_to?("#{field}=")
      send("#{field}=", value)
    elsif ! instance_variable_get("@#{field}").nil?
      instance_variable_set("@#{field}", value)
    else
      fail ArgumentError, "Unknown field '#{field}'"
    end
  end

  def level_bonus
    @class_strategy.level_bonus
  end

  def basic_health
    (base_hit_points + constitution_modifier).but_at_least(1)
  end

  def base_hit_points
    level * @class_strategy.hits_per_level
  end
end
