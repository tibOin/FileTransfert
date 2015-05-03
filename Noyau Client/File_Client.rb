require_relative '../Config/require'

class Client
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

end


client = Client_File.new
#client.send_up_request
#sleep 0.1
client.upload
#client.download