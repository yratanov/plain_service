require 'virtus'
require 'active_model'

module PlainService
  class Base
    include Virtus.model
    include ActiveModel::Validations

    def self.perform(params)
      new(params).perform
    end

    def perform
      if valid?
        process
      else
        false
      end
    end

    # Should return whether true or false value depending on success/fail status of service object actions
    def process
      raise NotImplementedError('You should implement #process method in your child class')
    end

    protected

    # Use it if you want to delegate errors from underlying object to service
    def pass_errors_from(object)
      object.errors.each do |key, error|
        errors.add key, error
      end
    end
  end
end
