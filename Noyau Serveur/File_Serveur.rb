require_relative '../Configurations/Requires/require'

class Serveur
  include Protocole_communication
  include Request_maker

  def initialize()

    @port = 22225
    @serveur = begin
      TCPServer.new(@port)
    rescue SystemCallError => ex
      raise "Impossible d'initialiser le serveur pour #{@port}: #{ex}"
    end

  end

  def listen()
    puts "Server is listening"

    loop do
      Thread.start(@serveur.accept) do |client|
        @client = client
        loop do
          treat_request
        end
      end
    end

  end

  def treat_request
    request = @client.gets.chomp
    header_options = request.split(HEADSPLIT)
    type = header_options[0]

    case type

      when 'download'
        puts ''

      when 'upload'

    end

  end

end

serveur = Serveur.new

serveur.listen