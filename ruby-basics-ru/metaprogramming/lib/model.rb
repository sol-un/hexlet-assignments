# frozen_string_literal: true

# BEGIN
module Model
  def coerce(value, type)
    case type
    when :string
      value.to_s
    when :integer
      value.to_i
    when :boolean
      !!value
    when :datetime
      DateTime.parse(value)
    else
      value
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(attributes = {})
    attributes.each do |key, value|
      define_method key do
        instance_variable_get "@#{key}"
      end

      define_method "#{key}=" do |new_value|
        instance_variable_set "@#{key}", coerce(new_value, options[:type])
      end

      instance_variable_set "@#{key}", value
    end
  end

  module ClassMethods
    def attribute(*attributes)
      puts('attribute')
      puts(attributes)
    end
  end
end
# END
