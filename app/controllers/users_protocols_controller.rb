class UsersProtocolsController < ApplicationController
  before_action :set_protocol, only: [:submit]

  def included
    @protocol = Protocol.find(params[:id])
    @user_protocol = UsersProtocol.where(protocol_id: params[:id], user_id: current_user.id).first

    @included_ieee = []
    @included_scidir = []
    @included_scopus = []
    @included_acm = []
    @included_springer = []

    if @protocol.ieee
      ieees_id = IeeesUsersProtocol.where(users_protocol_id: @user_protocol, included: true).select(:ieee_id)
      @included = Ieee.where(id: ieees_id)

      @included.each { |ieee|
        @included_ieee.push(ieee)
      }

      @count_ieee = @included_ieee.count.to_s
    end

    if @protocol.science_direct
      scidir_id = ScidirsUsersProtocol.where(users_protocol_id: @user_protocol, included: true).select(:scidir_id)
      @included = Scidir.where(id: scidir_id)

      @included.each { |scidir|
        @included_scidir.push(scidir)
      }

      @count_scidir = @included_scidir.count.to_s
    end

    if @protocol.scopus
      scopus_id = ScopusUsersProtocol.where(users_protocol_id: @user_protocol, included: true).select(:scopu_id)
      @included = Scopu.where(id: scopus_id)

      @included.each { |scopus|
        @included_scopus.push(scopus)
      }

      @count_scopus = @included_scopus.count.to_s
    end

    if @protocol.acm
      acms_id = AcmsUsersProtocol.where(users_protocol_id: @user_protocol, included: true).select(:acm_id)
      @included = Acm.where(id: acms_id)

      @included.each { |acm|
        @included_acm.push(acm)
      }

      @count_acm = @included_acm.count.to_s
    end

    if @protocol.springer
      springers_id = SpringersUsersProtocol.where(users_protocol_id: @user_protocol, included: true).select(:springer_id)
      @included = Springer.where(id: springers_id)

      @included.each { |springer|
        @included_springer.push(springer)
      }

      @count_springer = @included_springer.count.to_s
    end

    @empty_ieee = (@included_ieee.empty?) ? true : false
    @empty_scidir = (@included_scidir.empty?) ? true : false
    @empty_scopus = (@included_scopus.empty?) ? true : false
    @empty_acm = (@included_acm.empty?) ? true : false
    @empty_springer = (@included_springer.empty?) ? true : false

    @ref_protocol = reference_exist

    respond_to do |format|
      format.html
      format.xls
    end

  end

  def submit
    users_protocols = UsersProtocol.where(protocol: params[:id])
    @user_protocol = users_protocols.where(user_id: current_user.id).first
    @user_protocol.selection_submitted = true
    @user_protocol.save!
    @all_submitted = users_protocols.where(selection_submitted: false).empty?

    if @all_submitted
      Included.destroy_all(protocol_id: params[:id])
      if @protocol.ieee?
        ieees = Ieee.where(protocol_id: params[:id])
        ieees.each do |ieee|
          include_study(ieee, 'ieee')
          users_protocols.each do |user_protocol|
            if IeeesUsersProtocol.exists?(ieee_id: ieee.id, users_protocol_id: user_protocol.id)
              if IeeesUsersProtocol.where(ieee_id: ieee.id, users_protocol_id: user_protocol.id).first.included?
                @included.times_included = @included.times_included + 1
              else
                @included.times_excluded = @included.times_excluded + 1
              end
            end
          end
          if @included.times_excluded == 0
            @included.included = 1
            @included.save!
          else
            if @included.times_included == 0
              @included.destroy!
            else
              @included.save!
            end
          end
        end

      end

      if @protocol.scopus?
        scopus = Scopu.where(protocol_id: params[:id])
        scopus.each do |scopu|
          include_study(scopu, 'scopus')
          users_protocols.each do |user_protocol|
            if ScopusUsersProtocol.exists?(scopu_id: scopu.id, users_protocol_id: user_protocol.id)
              if ScopusUsersProtocol.where(scopu_id: scopu.id, users_protocol_id: user_protocol.id).first.included?
                @included.times_included = @included.times_included + 1
              else
                @included.times_excluded = @included.times_excluded + 1
              end
            end
          end
          if @included.times_excluded == 0
            @included.included = 1
            @included.save!
          else
            if @included.times_included == 0
              @included.destroy!
            else
              @included.save!
            end
          end
        end

      end

      if @protocol.science_direct?
        scidirs = Scidir.where(protocol_id: params[:id])
        scidirs.each do |scidir|
          include_study(scidir, 'scidir')
          users_protocols.each do |user_protocol|
            if ScidirsUsersProtocol.exists?(scidir_id: scidir.id, users_protocol_id: user_protocol.id)
              if ScidirsUsersProtocol.where(scidir_id: scidir.id, users_protocol_id: user_protocol.id).first.included?
                @included.times_included = @included.times_included + 1
              else
                @included.times_excluded = @included.times_excluded + 1
              end
            end
          end
          if @included.times_excluded == 0
            @included.included = 1
            @included.save!
          else
            if @included.times_included == 0
              @included.destroy!
            else
              @included.save!
            end
          end
        end

      end

      if @protocol.springer?
        springers = Springer.where(protocol_id: params[:id])
        springers.each do |springer|
          include_study(springer, 'springer')
          users_protocols.each do |user_protocol|
            if SpringersUsersProtocol.exists?(springer_id: springer.id, users_protocol_id: user_protocol.id)
              if SpringersUsersProtocol.where(springer_id: springer.id, users_protocol_id: user_protocol.id).first.included?
                @included.times_included = @included.times_included + 1
              else
                @included.times_excluded = @included.times_excluded + 1
              end
            end
          end
          if @included.times_excluded == 0
            @included.included = 1
            @included.save!
          else
            if @included.times_included == 0
              @included.destroy!
            else
              @included.save!
            end
          end
        end

      end

      if @protocol.acm?
        acms = Acm.where(protocol_id: params[:id])
        acms.each do |acm|
          include_study(acm, 'acm')
          users_protocols.each do |user_protocol|
            if AcmsUsersProtocol.exists?(acm_id: acm.id, users_protocol_id: user_protocol.id)
              if AcmsUsersProtocol.where(acm_id: acm.id, users_protocol_id: user_protocol.id).first.included?
                @included.times_included = @included.times_included + 1
              else
                @included.times_excluded = @included.times_excluded + 1
              end
            end
          end
          if @included.times_excluded == 0
            @included.included = 1
            @included.save!
          else
            if @included.times_included == 0
              @included.destroy!
            else
              @included.save!
            end
          end
        end

      end
    end

    redirect_to action: 'show_conflicts', id: params[:id]
  end

  def show_conflicts
    @all_submitted = UsersProtocol.where(protocol: params[:id], selection_submitted: false).empty?

    @acm_conflicts = Included.where(protocol_id: params[:id], name_database: 'acm', included: nil)
    @springer_conflicts = Included.where(protocol_id: params[:id], name_database: 'springer', included: nil)
    @scidir_conflicts = Included.where(protocol_id: params[:id], name_database: 'scidir', included: nil)
    @scopu_conflicts = Included.where(protocol_id: params[:id], name_database: 'scopus', included: nil)
    @ieee_conflicts = Included.where(protocol_id: params[:id], name_database: 'ieee', included: nil)
  end

  private

  def set_protocol
    @protocol = Protocol.find(params[:id])
  end

  def include_study(study, database_name)
    @included = Included.new

    @included.title = study.title
    @included.author = study.author
    @included.pubtitle = study.pubtitle
    @included.protocol_id = study.protocol_id
    @included.link = study.link
    @included.name_database = database_name
    @included.included = nil
  end

  # Verifica se alguma busca já foi realizada para aquele protocolo
  def reference_exist
    Reference.find_by_protocol_id(params[:id])
  end

end