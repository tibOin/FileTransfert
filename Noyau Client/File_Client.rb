require_relative '../Config/require'

class Client_File
  include Request_maker

  def initialize()
    @host = 'localhost'
    @port = "22225"
    @serveur = TCPSocket.new(@host, @port)
  end

  def download
    send_down_request(@serveur)
  end

  def upload
    send_up_request(@serveur)
  end

  def read_request()
    type, header_options = parse_requests(@serveur)
  end

=begin
  def parse_requests(sock)

    request = sock.gets.chomp
    header_options = request.split(HEADSPLIT)
    type = header_options.first

    puts request
    puts "#{header_options}"
    puts type

    case type
      when 'upload'

        filename = header_options[1]
        filesize = header_options.last
        sock.puts('ready')
        download(sock, filename, filesize)

      when 'download'

        puts 'download request'

      else

        puts 'erreur'
    end

  end

=end

end


client = Client_File.new
#client.send_up_request
#sleep 0.1
client.upload
#client.download