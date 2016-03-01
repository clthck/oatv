class Date
  def as_json(options = {})
    I18n.localize self
  end
end