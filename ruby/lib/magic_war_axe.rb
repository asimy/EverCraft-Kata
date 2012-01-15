require 'war_axe'

class MagicWarAxe < WarAxe
  def damage_bonus(defender)
    super + 2
  end
end
