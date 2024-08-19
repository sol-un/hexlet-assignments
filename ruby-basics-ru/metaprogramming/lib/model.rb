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

  module ClassMethods
    def attribute(name, options = {})
      define_method 'initialize' do |attributes = {}|
        attributes.each do |key, value|
          instance_variable_set "@#{key}", value
        end
      end

      define_method name do
        instance_variable_get "@#{name}"
      end

      define_method "#{name}=" do |value|
        instance_variable_set "@#{name}", coerce(value, options[:type])
      end
    end
  end
end
# END
