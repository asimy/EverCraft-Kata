require 'attack'
require 'standard_class'
require 'human_race'
require 'integer_extensions'

class Character
  attr_accessor :name
  attr_reader :alignment, :experience

  def self.ability(*names)
    names.each do |name|
      attr_accessor name
      define_method("#{name}_modifier") do
        value = send(name)
        ((value - 10) / 2) + @race.modifier_bonus_for(name)
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
    @alignment = :neutral
    klass = options.delete(:class) || StandardClass
    @class = klass.new(self)
    race = options.delete(:race) || HumanRace
    @race = race.new(self)
    fail ArgumentError, "No block allowed on initializer" if block_given?
    set options
  end

  def race
    @race.racial_name
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

  def armor_class(attacker)
    @base_armor_class + @class.armor_bonus(attacker) + @race.armor_bonus(attacker)
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
    @class.base_damage(defender) + @race.damage_bonus(defender)
  end

  def dead?
    hit_points < 1
  end

  def critical_damage_multiplier(defender)
    @class.critical_damage_multiplier(defender)
  end

  def normal_damage_multiplier_for(defender)
    @class.normal_damage_multiplier_for(defender)
  end

  def take_damage(damage)
    @total_damage += damage.but_at_least(1)
  end

  def gains_experience(xp)
    @experience += xp
  end

  def critical?(die_value)
    die_value >= (20 - @race.critical_range_bonus)
  end

  def attack_bonus(defender)
    level_bonus + @class.attack_bonus(defender) + @race.attack_bonus(defender)
  end

  def choose_defenders_armor(base_armor, normal_armor)
    @class.choose_defenders_armor(base_armor, normal_armor)
  end

  private

  def set(options={})
    options.each do |field, value|
      set_field field, value
    end
  end

  def set_field(field, value)
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
    @class.level_bonus
  end

  def basic_health
    (base_hit_points + @race.hit_point_multiplier * constitution_modifier).but_at_least(1)
  end

  def base_hit_points
    level * @class.hits_per_level
  end
end
