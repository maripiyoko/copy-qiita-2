module FindByName extend ActiveSupport::Concern

  module ClassMethods
    def find_by_param(id)
      self.find_by_name!(id)
    end
  end

  def to_param
    self.name
  end
end