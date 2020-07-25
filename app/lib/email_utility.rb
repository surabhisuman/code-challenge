class EmailUtility
  def self.get_domain(email)
    email.to_s.downcase.split('@').last
  end
end