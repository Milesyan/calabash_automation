require 'httparty'
require_relative 'app'

module GlowLogger
  GLOW_EVENTS_URL = "http://dragon-appevents.glowing.com"

  class EventLogger
    include HTTParty
    extend Glow

    base_uri GLOW_EVENTS_URL

    attr_accessor :start_time, :end_time, :res
    attr_accessor :expected, :actual
    attr_accessor :start_version

    def initialize
      @expected = []
      @actual = []
    end

    def new_log(args)
      {
        "event_name" => args[:event_name],
        "local_ts" => Time.now.to_i
      }
    end

    def diff
      puts yellow("+"*20 + " expected events " + "+"*20)
      @expected.each do |log|
        t = Time.at(log["local_ts"])
        print yellow("#{time_str(t)} ")
        log_msg log["event_name"]
      end

      expected_uniq = @expected.collect { |log| log.values_at "event_name"}.flatten.uniq
      actual_uniq = @actual.collect { |log| log.values_at "event_name"}.flatten.uniq

      puts yellow("+"*20 + " actual - expected " + "+"*20)

      (actual_uniq - expected_uniq).each do |d|
        log_msg("+ " + d) 
      end

      puts yellow("-"*20 + " expected not in actual " + "-"*20)

      (expected_uniq - actual_uniq).each do |d|
        puts red("- " + d) 
      end
    end

    def add(args)
      log = new_log(args)
      expected << log
    end

    def clear
      @expected = []
      @actual = []
    end

    def time_str(t)
      t.strftime("%v %T")
    end

    def start
      t = Time.now
      @start_time = t.to_i
      puts yellow("-" * 20 + " start_time: #{time_str(t)} " + "-" * 20) 
    end

    def stop
      t = Time.now
      @end_time = t.to_i
      puts yellow("-" * 20 + " end_time: #{time_str(t)} " + "-" * 20)
    end

    def pull_log(args)
      data = {
        "start_time": args[:start_time] || @start_time,
        "end_time": args[:end_time] || @end_time,
        "email": args[:email] || args[:user].email
      }.to_param

      puts yellow("#{GLOW_EVENTS_URL}/emma?#{data}")

      @res = self.class.get "/emma?#{data}"
      @actual = @res["events"]
      self
    end

    def pretty
      puts green("-"*20 + " events logged at server side" + "-"*20)
      @res["events"].each do |log|
        t = Time.at(log["server_ts"].to_i)
        print yellow("#{time_str(t)} ")
        log_msg(log["event_name"]) 
      end
    end
  end

  def logger
    $logger ||= EventLogger.new
  end

end