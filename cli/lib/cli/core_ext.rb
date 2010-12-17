module BoshExtensions
  def say(message)
    Bosh::Cli::Config.output.puts(message) if Bosh::Cli::Config.output
  end

  def err(message)
    raise Bosh::Cli::CliExit, message
  end

  def blank?
    self.to_s.blank?
  end
end

module BoshStringExtensions
  def red
    colorize("\e[0m\e[31m")
  end

  def green
    colorize("\e[0m\e[32m")    
  end

  def colorize(color_code)
    if Bosh::Cli::Config.colorize
      "#{color_code}#{self}\e[0m"
    else
      self
    end
  end

  def blank?
    self =~ /^\s*$/
  end  
end

class Object
  include BoshExtensions
end

class String
  include BoshStringExtensions
end