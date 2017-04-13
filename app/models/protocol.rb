class Protocol < ActiveRecord::Base

  has_many :users_protocols, dependent: :destroy
  has_many :users, through: :users_protocols
  has_many :terms, :dependent => :destroy
  has_many :references
  accepts_nested_attributes_for :terms, :allow_destroy => true
  accepts_nested_attributes_for :users_protocols, :allow_destroy => true,
                                reject_if: proc {
                                    |attributes| attributes['user_id'].blank? || attributes['role_id'].blank?
                                }
  validates_presence_of :title, :terms, :from, :to, :users_protocols

  attr_accessor :ref_exists

  def clean_bases (protocol_id)

    # Clean all databases before doing other search

    Ieee.delete_all "protocol_id = #{protocol_id}"
    Scidir.delete_all "protocol_id = #{protocol_id}"
    Scopu.destroy_all "protocol_id = #{protocol_id}"
    Acm.delete_all "protocol_id = #{protocol_id}"
    Springer.delete_all "protocol_id = #{protocol_id}"

    Included.delete_all "protocol_id = #{protocol_id}"

    Reference.delete_all "protocol_id = #{protocol_id}"

  end

  def generate_string(attributes)

    @termos = ''

    attributes.values.each_with_index do |term, index|

      termo = term[:termo].parameterize

      sinonimo = term[:sinonimo] == "" ? '' : '" OR "' + term[:sinonimo].parameterize

      sinonimo2 = term[:sinonimo2] == "" ? '' : '" OR "' + term[:sinonimo2].parameterize

      traducao = term[:traducao] == "" ? '' : '" OR "' + term[:traducao].parameterize

      traducao2 = term[:traducao2] == "" ? '' : '" OR "' + term[:traducao2].parameterize

      traducao3 = term[:traducao3] == "" ? '' : '" OR "' + term[:traducao3].parameterize

      @termos += (index == attributes.size - 1) ?
          '("' + termo + traducao + sinonimo + sinonimo2 + traducao2 + traducao3 + '")' :
          '("' + termo + traducao + sinonimo + sinonimo2 + traducao2 + traducao3 + '")' + ' AND '
    end

    return @termos
  end

end
