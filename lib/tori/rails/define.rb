module Tori
  module Rails
    module Define
      extend Tori::Define

      def tori(name, args, &block)
        register_callbacks(name, args)

        args.delete(:store_key)
        args.delete(:before_upload)
        args.delete(:skip_upload)
        args.delete(:after_upload)
        args.delete(:skip_destroy)

        super(name, args, &block)
      end

      private

      def register_callbacks(name, args)
        Array(args[:store_key]).each do |store_key|
          callback.register(:store_key, name: name, key: store_key)
        end
        Array(args[:before_upload]).each do |method|
          callback.register(:before_upload, name: name, callback: method)
        end
        callback.register(:upload, name: name) unless args[:skip_upload]
        Array(args[:after_upload]).each do |method|
          callback.register(:after_upload, name: name, callback: method)
        end
        callback.register(:destroy, name: name) unless args[:skip_destroy]
      end
    end
  end
end
