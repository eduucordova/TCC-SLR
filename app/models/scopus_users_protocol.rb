
class ScopusUsersProtocol < ActiveRecord::Base

  # def self.randomize_studies (user_protocol_id, range)
  #   user_protocol = UsersProtocol.find(user_protocol_id)
  #   protocol = user_protocol.protocol
  #   scopus = Scopu.where('protocol_id = ?', protocol.id)
  #   total = scopus.count()
  #   distribute = (total*(range.to_i)*0.01).to_i
  #
  # end

  def self.randomize_studies (user_hash, protocol)
    studies = Scopu.where('protocol_id = ?', protocol.id)
    total = studies.count()
    user_hash.each do {||}

    end
  end

end