module IOSConfig
  extend TestHelper
  def base_url() load_config["base_urls"]["Sandbox"] end
  def forum_base_url() load_config["base_urls"]["SandboxForum"] end

  module_function :base_url, :forum_base_url
end

module AndroidConfig
  extend TestHelper
  def base_url() load_config["base_urls"]["Sandbox1"] end
  def forum_base_url() load_config["base_urls"]["SandboxForum1"] end

  module_function :base_url, :forum_base_url
end
