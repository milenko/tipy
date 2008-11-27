module Paperclip
  class Attachment
    def convert_options
      @convert_options.respond_to?('call') ? @convert_options.call(@instance) : @convert_options
    end
  end
end