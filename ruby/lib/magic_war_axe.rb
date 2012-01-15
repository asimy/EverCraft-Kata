require 'war_axe'

class MagicWarAxe < WarAxe
  def damage_bonus(attacker, defender)
    super + 2
  end
end
