require_relative '../Config/com_protocole'

module Request_maker

  def parse_requests(request)

    header_options = request.split(Protocole_communication::HEADSPLIT)
    return header_options

  end

  def forge_request(options = [])
    type = options[0]
    opiton = options[1]
    option = options[2]

    case type

      when 'upload'
        filesize = File.size("../Downloads/#{opiton}")
        request = Protocole_communication.forge_header(type, option, filesize)
        return request

      when 'download'
        request = Protocole_communication.forge_header(type, opiton, option)
        return request

      else
        raise "Impossible de forger la requête. type = '#{type}'. type != 'upload' ou 'download'"
        return false
    end

  end

  def send_request(sock, request)

    begin
      sock.puts(request)
    rescue
      raise "Impossible d'envoyer la requête : '#{request}'"
    end

  end

  def read_answer(sock)

  end

  def send_up_request(sock, filepath = '../Downloads/TestVideoOriginal.mp4', outname = 'TestVideoCopie.mp4')
    head_type = 'upload'
    filesize = File.size(filepath)
    request = Protocole_communication.forge_header(head_type, outname, filesize)

    sock.puts request

    answer = sock.gets.chomp
    puts answer

    case answer
      when 'ready'
        Fly.upload(sock, filepath, filesize)
      else
        puts 'erreur answer'
    end
  end

  def send_down_request(sock, filename = 'TestVideoOriginal.mp4', outname = 'TestVideoReverse.mp4')

    head_type = 'download'
    request = Protocole_communication.forge_header(head_type, filename, outname)

    puts request
    sock.puts request
    parse_requests(sock)

  end

end
