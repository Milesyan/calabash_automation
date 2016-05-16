module IOSConfig
  extend TestHelper
  if APP_CONFIG.end_with? 'local'
    def base_url() load_config["base_urls"]["#{APP_CONFIG}"] end
    def forum_base_url() load_config["base_urls"]["Forum-local"] end
    def bryo_url() load_config["base_urls"]["Bryo-local"] end
  else 
    def base_url() load_config["base_urls"]["#{APP_CONFIG}-www0"] end
    def forum_base_url() load_config["base_urls"]["Forum-www0"] end
    def bryo_url() load_config["base_urls"]["Bryo-www0"] end
  end

  module_function :base_url, :forum_base_url, :bryo_url
end

module AndroidConfig
  extend TestHelper
  if APP_CONFIG.end_with? 'local'
    def base_url() load_config["base_urls"]["#{APP_CONFIG}"] end
    def forum_base_url() load_config["base_urls"]["Forum-local"] end
    def bryo_url() load_config["base_urls"]["Bryo-local"] end
  else 
    def base_url() load_config["base_urls"]["#{APP_CONFIG}-www1"] end
    def forum_base_url() load_config["base_urls"]["Forum-www1"] end
    def bryo_url() load_config["base_urls"]["Bryo-www1"] end
  end

  module_function :base_url, :forum_base_url, :bryo_url
end
