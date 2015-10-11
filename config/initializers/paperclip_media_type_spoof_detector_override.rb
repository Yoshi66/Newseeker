require 'paperclip/media_type_spoof_detector'
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
Paperclip.options[:content_type_mappings] = {
  pem: 'text/plain'
}
Paperclip.options[:content_type_mappings] = {
    pdf: "application/pdf"
  }
  Paperclip.options[:content_type_mappings] = {:csv => "text/plain"}
