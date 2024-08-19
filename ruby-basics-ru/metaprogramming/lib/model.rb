# frozen_string_literal: true

# BEGIN
module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attribute(name, options = {})
      define_method name do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        coerced_value = case options[:type]
                        when :string
                          value.to_s
                        when :integer
                          value.to_i
                        when :boolean
                          !!value
                        when :datetime
                          DateTime.parse(value)
                        end
        instance_variable_set "@#{name}", coerced_value
      end
    end
  end
end
# END
