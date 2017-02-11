
class SpringersUsersProtocol < ActiveRecord::Base

  # user_hash = {user_protocol_id, percentage}
  def self.randomize_studies (user_hash, protocol)
    studies = Springer.where('protocol_id = ?', protocol.id)
    total = studies.count()

    # change the percentage to an actual number of studies
    user_hash.each { |key, value| user_hash[key] = (value*total*0.01).to_i }

    user_array = user_hash.to_a

    study_index = 0
    user_index = 0
    stopped = 0
    while stopped != user_array.count
      user_index = user_index.modulo(user_array.count)

      if !user_array[user_index][0].nil?
        study_index += 1
        user_array[user_index][1] -= 1
        study_index = study_index.modulo(studies.count)
        SpringersUsersProtocol.create(:users_protocol_id => user_array[user_index][0], :springer_id => studies[study_index].id)
        if user_array[user_index][1].zero?
          user_array[user_index][0] = nil
          stopped += 1
        end
      end
      user_index += 1
    end
  end
end