require_relative '../Configurations/Requires/require'

class Serveur
  include Protocole_communication
  include Request_maker
  include Fly

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
        request = forge_request('upload', 'TestFileOriginal.txt', 'TestFileCopie.txt')

        if request == false
          raise "Erreur lors de la création de la requête" and exit
        else
          @client.puts request
        end

      when 'upload'

        filename = header_options[1]
        filesize = header_options.last

        @client.puts 'DLReady'
        download(@cl, filename, filesize)

      when 'DLReady'
        path = '../Telechargements/TestFileOriginal.txt'
        size = File.size(path)
        upload(@client, path, size)

      else
        puts 'not implemented yet'
    end

  end

end

serveur = Serveur.new

serveur.listen