require "socket"
require "option_parser"

# TODO: Write documentation for `Knocker`
module Knocker

  address = ""
  ports = ""

  OptionParser.parse! do |parser|
    parser.banner = "Usage: knocker [arguments]"
    parser.on("-a ADDRESS", "--address=ADDRESS", "Sets the IP address") { |i| address = i }
    parser.on("-p PORTS", "--ports=PORTS", "Specifies the ports separated by commas") { |p| ports = p }
    parser.on("-h", "--help", "Show this help") { puts parser }
  end

  sock = Socket.tcp(Socket::Family::INET)

  "#{ports}".split(",").each { |p|
    begin
      sock.connect(address, p.to_i)
    rescue
      puts "knocking... #{address}:#{p}"
    end
  }
end
