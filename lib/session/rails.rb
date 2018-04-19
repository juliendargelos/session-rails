require "session/rails/railtie"

module Session
  module Rails
    require __dir__ + '/engine'
    require __dir__ + '/core_ext'

    require __dir__ + '/validations'
    require __dir__ + '/attributes'
    require __dir__ + '/storage'
    require __dir__ + '/comparisons'
  end

  class Base
    include ActiveModel::Model

    include Validations
    include Attributes
    include Storage
    include Comparisons
  end
end
