module Session
  module Validations
    extend ActiveSupport::Concern

    included do
      validate(
        :public_attribute_is_present,
        :private_attribute_is_present,
        :session_is_valid
      )

      def authenticate
        model&.authenticate private_attribute
      end

      protected

      def public_attribute_is_present
        attribute_is_present self.class.public_attribute, public_attribute
      end

      def private_attribute_is_present
        attribute_is_present self.class.private_attribute, private_attribute
      end

      def session_is_valid
        if public_attribute.present? && private_attribute.present? && !authenticate
          errors.add :base, I18n.t("activerecord.errors.models.#{self.class.to_s.underscore.sub '/', '_'}.invalid")
        end
      end

      def attribute_is_present(name, value)
        if value.blank?
          errors.add name, I18n.t("activerecord.errors.models.#{self.class.to_s.underscore.sub '/', '_'}.attributes.#{name}.blank")
        end
      end
    end
  end
end
