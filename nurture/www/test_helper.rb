module TestHelper
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def red(text); colorize(text, 31); end
  def green(text); colorize(text, 32); end
  def yellow(text); colorize(text, 33); end
  def blue(text); colorize(text, 34); end
  def magenta(text); colorize(text, 35); end
  def cyan(text); colorize(text, 36); end
  def yellow_background(text); colorize(text, 43); end
  def magenta_background(text); colorize(text, 45); end
  def exchange_foreground_and_background(text); colorize(text, 7); end
  def light_red(text); colorize(text, 91); end
 

  def log_msg(msg)
    puts magenta(msg)
  end
  
  def sky_blue(text); colorize(text, 95); end
  
  def log_important(msg)
    puts sky_blue(msg)
  end
  
  def log_error(msg)
    puts light_red(msg)
  end

  def load_config
    config_folder = File.expand_path("./config", File.dirname(__FILE__))
    config = Dir[File.join(config_folder, '*.yml')].map {|f| [File.basename(f, '.yml').to_s, YAML.load_file(f)]}
    Hash[config]
  end
end