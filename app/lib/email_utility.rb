class EmailUtility
  def self.get_domain(email)
    email.split('@').last
  end
end