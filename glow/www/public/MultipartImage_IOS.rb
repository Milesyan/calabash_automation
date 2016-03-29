require 'rubygems'
require 'mime/types'


module MultipartImage
  VERSION = "1.0.0"
  class Post
    BOUNDARY = "----------------------120024863801960615717959499895"
    HEADER_CONTENT_TYPE = "multipart/form-data; boundary=#{ BOUNDARY }"
    HEADER = { "Content-Type" => HEADER_CONTENT_TYPE, "User-Agent" => "Glow%20Beta/201511301906 CFNetwork/711.5.6 Darwin/14.0.0" }
    def self.prepare_query(params)
      fp = []

      params.each do |k, v|
        if v.respond_to?(:path) and v.respond_to?(:read) then
          fp.push(FileParam.new(k, v.path, v.read))
        else
          fp.push(StringParam.new(k, v))
        end
      end
      query = fp.collect {|p| "--" + BOUNDARY + "\r\n" + p.to_multipart }.join("") + "--" + BOUNDARY + "--"
      return query, HEADER
    end
  end

  private
  class StringParam
    attr_accessor :k, :v

    def initialize(k, v)
      @k = k
      @v = v
    end

    def to_multipart
      return "Content-Disposition: form-data; name=\"#{k}\"\r\n\r\n#{v}\r\n"
    end
  end

  class FileParam
    attr_accessor :k, :filename, :content

    def initialize(k, filename, content)
      @k = k
      @filename = filename
      @content = content
    end

    def to_multipart
      mime_type = MIME::Types["application/octet-stream"][0]
      return "Content-Disposition: attachment; name=\"#{k}\"; filename=\"file\"\r\n" +
             "Content-Type: #{ mime_type.simplified }\r\n\r\n#{ content }\r\n"
    end
  end
end