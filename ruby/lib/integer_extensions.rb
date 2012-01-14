class Integer
  def but_at_least(n)
    self > n ? self : n
  end

  def D(n)
    (1..self).inject(0) { |s, _| s + rand(n) + 1 }
  end
end
