require 'rubygems'

module MultipartImage
  VERSION = "1.0.0"
  class Post

    BOUNDARY = "0a4163c2-e8a5-4a27-a422-a3779f8af749"
    HEADER_CONTENT_TYPE = "multipart/form-data; boundary=#{ BOUNDARY }"
    HEADER = { "Content-Type" => HEADER_CONTENT_TYPE, "User-Agent" => "okhttp/2.4.0"}
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
      @content_length = v.size
    end

    def to_multipart
      return "Content-Disposition: form-data; name=\"#{k}\"\r\nContent-Type: text/plain; charset=UTF-8\r\n"+
             "Content-Length: #{@content_length}\r\nContent-Transfer-Encoding: binary\r\n\r\n#{v}\r\n"
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
      mime_type = "image/jpeg"
      return "Content-Disposition: form-data; name=\"#{k}\"; filename=\"0.jpg\"\r\n" +
             "Content-Type: #{ mime_type }; charset=UTF-8\r\nContent-Transfer-Encoding: binary\r\n\r\n#{ content }\r\n"
    end
  end
end