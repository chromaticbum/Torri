class StateValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless ::State.where('lower(name) = lower(?)', value).exists?
      record.errors.add(attr_name, :state, options.merge(:value => value))
    end
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_state(*attr_names)
    validates_with StateValidator, _merge_attributes(attr_names)
  end
end

module ClientSideValidations::Middleware
  class State < Base
    def response
      if ::State.where('lower(name) = lower(?)', request.params[:name]).exists?
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end

class CityValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    state = ::State.where('lower(name) = lower(?)', record.state).first
    unless state and state.cities.where('lower(name) = lower(?)', value).exists?
      record.errors.add(attr_name, :city, options.merge(:value => value))
    end
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_city(*attr_names)
    validates_with CityValidator, _merge_attributes(attr_names)
  end
end

module ClientSideValidations::Middleware
  class City < Base
    def response
      state = ::State.where('lower(name) = lower(?)', request.params[:state_name]).first
      if not state.nil? and state.cities.where('lower(name) = lower(?)', request.params[:name]).exists?
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end

class MondayValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    if value.nil? or not value.monday?
      record.errors.add(attr_name, :monday, options.merge(:value => value))
    end
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_monday(*attr_names)
    validates_with MondayValidator, _merge_attributes(attr_names)
  end
end

class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    if value.nil?
      record.errors.add(attr_name, :date, options.merge(:value => value))
    end
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_date(*attr_names)
    validates_with DateValidator, _merge_attributes(attr_names)
  end
end
