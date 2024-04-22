# frozen_string_literal: true

module Forms
  class Base
    include ActiveModel::Model
    include ActiveModel::Callbacks
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
    include ActiveModel::Attributes
  end
end
