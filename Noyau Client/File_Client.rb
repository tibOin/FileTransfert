require_relative '../Configurations/Requires/require'

class Client
  include Request_maker
  include Fly
  include Protocole_communication

  def initialize()
    @host = 'localhost'
    @port = "22225"
    @serveur = TCPSocket.new(@host, @port)
  end

  def treat_request
    request = @serveur.gets.chomp
    header_options = request.split(HEADSPLIT)
    type = header_options[0]

    case type

      when 'download'
        request = forge_request('upload', 'TestFileOriginal.txt', 'TestFileCopie.txt')

        if request == false
          raise "Erreur lors de la création de la requête" and exit
        else
          @serveur.puts request
        end

      when 'upload'
        filename = header_options[1]
        filesize = header_options.last

        @serveur.puts 'DLReady'
        download(@serveur, filename, filesize)

      when 'DLReady'
        path = '../Telechargements/TestFileOriginal.txt'
        size = File.size(path)
        upload(@client, path, size)

      else
        puts 'not implemented yet'
    end

  end

  def read_request()
    type, header_options = parse_requests(@serveur)
  end

end


client = Client_File.new
#client.send_up_request
#sleep 0.1
client.upload
#client.download