module Session
  module Attributes
    extend ActiveSupport::Concern

    DEFAULT_MODEL_NAME = :user
    DEFAULT_ID_ATTRIBUTE = :id
    DEFAULT_PUBLIC_ATTRIBUTE = :email
    DEFAULT_PRIVATE_ATTRIBUTE = :password

    included do
      attr_accessor :public_attribute, :private_attribute

      def id
        return nil if model.blank?
        model.send self.class.id_attribute
      end

      def id=(v)
        return self.model = nil if v.nil?
        self.model = self.class.model.find_by self.class.id_attribute => v
      end

      def model
        return nil if public_attribute.blank?
        self.class.model.find_by self.class.public_attribute => public_attribute
      end

      def model=(v)
        self.public_attribute = v.try self.class.public_attribute
      end

      authenticates
    end

    class_methods do
      attr_reader :model_name, :id_attribute, :public_attribute, :private_attribute

      def model
        @model ||= model_name.to_s.classify.constantize
      end

      def authenticates(model_name = nil, by: nil)
        alias_accessor :model, :model_name do
          @model_name = (model_name.to_s.underscore.presence || DEFAULT_MODEL_NAME).to_sym
          @model = nil
        end

        attributes = by&.symbolize_keys.presence || {}

        alias_accessor(:id, :id_attribute) { @id_attribute = attributes[:id].to_s.to_sym.presence || DEFAULT_ID_ATTRIBUTE }
        alias_accessor(:public_attribute) { @public_attribute = attributes[:public].to_s.to_sym.presence || DEFAULT_PUBLIC_ATTRIBUTE }
        alias_accessor(:private_attribute) { @private_attribute = attributes[:private].to_s.to_sym.presence || DEFAULT_PRIVATE_ATTRIBUTE }
      end

      def columns
        [
          Struct.new(:name, :type).new(public_attribute, :string),
          Struct.new(:name, :type).new(private_attribute, :string)
        ]
      end

      protected

      def alias_accessor(name, name_method = nil)
        method_name = send name_method || name
        if method_name.present? && method_name.to_s != name.to_s
          remove_method method_name if respond_to? method_name
          remove_method "#{method_name}=" if respond_to? "#{method_name}="
        end

        yield

        method_name = send name_method || name
        if method_name.to_s != name.to_s
          alias_method method_name, name
          alias_method "#{method_name}=", "#{name}="
        end
      end
    end
  end
end
