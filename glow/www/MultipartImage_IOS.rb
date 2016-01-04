# Takes a hash of string and file parameters and returns a string of text
# formatted to be sent as a multipart form post.
#
# Author:: Cody Brimhall <mailto:brimhall@somuchwit.com>
# Created:: 22 Feb 2008
# License:: Distributed under the terms of the WTFPL (http://www.wtfpl.net/txt/copying/)

require 'rubygems'
require 'mime/types'


module MultipartImage
  VERSION = "1.0.0"

  # Formats a given hash as a multipart form post
  # If a hash value responds to :string or :read messages, then it is
  # interpreted as a file and processed accordingly; otherwise, it is assumed
  # to be a string
  class Post
    # We have to pretend we're a web browser...
    BOUNDARY = "----------------------120024863801960615717959499895"
    HEADER_CONTENT_TYPE = "multipart/form-data; boundary=#{ BOUNDARY }"
    # UT = "eSUquebm1-FtQNrvNCbxtAZItVFEeoREat5FBlrRjKKzAeKouEInuT420T9jW-QK1qt5edg4P44x54yEOu6Q6Q=="
    HEADER = { "Content-Type" => HEADER_CONTENT_TYPE, "User-Agent" => "Glow%20Beta/201511301906 CFNetwork/711.5.6 Darwin/14.0.0" }
    def self.prepare_query(params)
      fp = []

      params.each do |k, v|
        # Are we trying to make a file parameter?
        if v.respond_to?(:path) and v.respond_to?(:read) then
          fp.push(FileParam.new(k, v.path, v.read))
        # We must be trying to make a regular parameter
        else
          fp.push(StringParam.new(k, v))
        end
      end

      # Assemble the request body using the special multipart format
      query = fp.collect {|p| "--" + BOUNDARY + "\r\n" + p.to_multipart }.join("") + "--" + BOUNDARY + "--"
      return query, HEADER
    end
  end

  # private

  # Formats a basic string key/value pair for inclusion with a multipart post
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

  # Formats the contents of a file or string for inclusion with a multipart
  # form post
  class FileParam
    attr_accessor :k, :filename, :content

    def initialize(k, filename, content)
      @k = k
      @filename = filename
      @content = content
    end

    def to_multipart
      # If we can tell the possible mime-type from the filename, use the
      # first in the list; otherwise, use "application/octet-stream"
      mime_type = MIME::Types["application/octet-stream"][0]
      return "Content-Disposition: attachment; name=\"#{k}\"; filename=\"file\"\r\n" +
             "Content-Type: #{ mime_type.simplified }\r\n\r\n#{ content }\r\n"
    end
  end
end