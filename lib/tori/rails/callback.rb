module Tori
  module Rails
    class Callback
      def initialize
        @callbacks = {
          store_key:     [],
          before_upload: [],
          upload:        [],
          after_upload:  [],
          destroy:       []
        }
      end

      def register(type, args)
        @callbacks[type] << {
          name:     args[:name],
          callback: args[:callback],
          args:     args.slice!(:name, :callback)
        }
      end

      def before_validation(record)
        @callbacks[:store_key].each do |callback|
          store_dummy_key(record, key: callback[:args][:key])
        end
      end

      def after_save(record)
        @callbacks[:before_upload].each do |callback|
          record.send(callback[:callback], name: callback[:name])
        end
        @callbacks[:upload].each do |callback|
          upload_image(record, name: callback[:name])
        end
        @callbacks[:after_upload].each do |callback|
          record.send(callback[:callback], name: callback[:name])
        end
        @callbacks[:store_key].each do |callback|
          store_key(record, name: callback[:name], key: callback[:args][:key])
        end
      end

      def after_destroy(record)
        @callbacks[:destroy].each do |callback|
          destroy_image(record, name: callback[:name])
        end
      end

      private

      def content_type(record, name:)
        FileMagic.open(FileMagic::MAGIC_MIME) do |fm|
          mime = fm.buffer(record.send(name).from)
          mime = 'image/svg+xml' if mime.split(';')[0] == 'application/xml' # application/xml は SVG と判断する
          mime
        end
      end

      def upload_image(record, name:)
        record.send(name).write(content_type: content_type(record, name: name), acl: "public-read") if record.send(name).from?
      end

      def destroy_image(record, name:)
        record.send(name).delete
      end

      def store_dummy_key(record, key:)
        # for evade validation errors
        record.send(:write_attribute, key, "dummy")
      end

      def store_key(record, name:, key:)
        s3_key = record.send(name).name
        fail ErrorStoredKeyMissing unless s3_key.present?
        record.update_column(key, s3_key)
      end
    end
  end
end
