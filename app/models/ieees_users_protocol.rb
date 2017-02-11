class IeeesUsersProtocol < ActiveRecord::Base

  def self.randomize_studies(user_protocol_id, range)
    user_protocol = UsersProtocol.find(user_protocol_id)
    protocol = user_protocol.protocol
    ieees = Ieee.where('protocol_id = ?', protocol.id)
    total = ieees.count()
    ditribute = (total*range*0.1).to_i

    IeeesUsersProtocol.create(ieee_id: 1, user_protocol_id: user_protocol_id)
  end

end
