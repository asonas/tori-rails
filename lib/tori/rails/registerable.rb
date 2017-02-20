module Tori
  module Rails
    module Registerable
      extend ActiveSupport::Concern

      included do
        extend Tori::Rails::Define
        @tori_rails_callback = Tori::Rails::Callback.new

        before_validation @tori_rails_callback
        after_save        @tori_rails_callback
        after_destroy     @tori_rails_callback
      end

      class_methods do
        def callback
          @tori_rails_callback
        end
      end
    end
  end
end
