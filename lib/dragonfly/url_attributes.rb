require 'ostruct'

module Dragonfly
  class UrlAttributes < OpenStruct
    include HasFilename # Updating ext / basename also updates the name

    def empty?
      @table.reject{|k, v| v.nil? }.empty?
    end

    # Hack so we can use .send('format') and it not call the private Kernel method
    def format
      @table[:format]
    end

    def extract(keys)
      keys.inject({}) do |attrs, key|
        value = send(key)
        attrs[key] = value unless value.blank?
        attrs
      end
    end
  end
end

