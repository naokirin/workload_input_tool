# frozen_string_literal: true

module UsecaseCallable
  extend ActiveSupport::Concern

  included do
    def self.call(**args)
      new(**args).call
    end

    def call
      raise NotImplementedError
    end
  end
end
