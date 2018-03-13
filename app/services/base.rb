module Base
  extend ActiveSupport::Concern

  class_methods do
    def perform! *args, &block
      @instance ||= new
      @instance.perform!(*args, &block)
    end
  end
end
