ActionController::Base.class_eval do
  before_action :initialize_sessions
  before_action :check_session_authentications

  protected

  def initialize_sessions
    Session::Base.descendants.each { |session| session.store = self.session }
  end

  def check_session_authentications
    self.class.authentication_requirements.each do |session|
      redirect_to controller: session.to_s.tableize, action: :new and return unless session.current.exists?
    end
  end

  def check_session_unauthentications
    self.class.unauthentication_requirements.each do |session|
      redirect_to root_path if session.current.exists?
    end
  end

  class << self
    def requires_authentication(from: :session)
      (authentication_requirements << from.to_s.classify.constantize).uniq!
    end

    def requires_unauthentication(from: :session)
      (unauthentication_requirements << from.to_s.classify.constantize).uniq!
    end

    protected

    def authentication_requirements
      @authentication_requirements ||= []
    end

    def unauthentication_requirements
      @unauthentication_requirements ||= []
    end
  end
end
