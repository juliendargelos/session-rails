module Session
  module Comparisons
    extend ActiveSupport::Concern

    included do
      def ==(session)
        session.is_a?(self.class) && id.present? && id == session.id
      end
    end
  end
end
