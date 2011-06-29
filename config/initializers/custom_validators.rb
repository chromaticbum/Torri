class StateValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless ::State.where(:name => value).exists?
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
      if ::State.where(:name => request.params[:name]).exists?
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
    state = ::State.find_by_name(record.state)
    unless state and state.cities.where('name = ?', value).exists?
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
      state = ::State.find_by_name(request.params[:state_name])
      if not state.nil? and state.cities.where('name = ?', request.params[:name]).exists?
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end