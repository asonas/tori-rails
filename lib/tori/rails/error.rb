module Tori
  module Rails
    module Error
      class StoredKeyMissing < StandardError; end
      class StoredColumnMissing < StandardError; end
    end
  end
end
