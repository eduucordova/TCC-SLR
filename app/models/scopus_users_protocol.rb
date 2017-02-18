class ScopusUsersProtocol < ActiveRecord::Base

  # user_hash = {user_protocol_id, percentage}
  def self.randomize_studies (user_hash, protocol)
    studies = Scopu.where('protocol_id = ?', protocol.id)
    ScopusUsersProtocol.where(scopu_id: studies).delete_all
    total = studies.count()

    # change the percentage to an actual quantity of studies
    user_quantity = {}
    user_hash.each do |key, value|
      user_quantity[key] = (value*total*0.01).to_i
    end

    user_array = user_quantity.to_a

    study_index = 0
    user_index = 0
    stopped = 0
    while stopped != user_array.count
      user_index = user_index.modulo(user_array.count)

      if !user_array[user_index][0].nil?
        if user_array[user_index][1].zero?
          user_array[user_index][0] = nil
          stopped += 1
        else
          user_array[user_index][1] -= 1
          study_index = study_index.modulo(studies.count)
          while ScopusUsersProtocol.exists?(:users_protocol_id => user_array[user_index][0], :scopu_id => studies[study_index].id)
            study_index += 1
            study_index = study_index.modulo(studies.count)
          end
          ScopusUsersProtocol.create(:users_protocol_id => user_array[user_index][0], :scopu_id => studies[study_index].id)
          study_index += 1
        end
      end
      user_index += 1
    end

  end
end