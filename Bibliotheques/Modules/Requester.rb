require_relative '../Config/com_protocole'
require_relative '../Libs/Fly'

module Request_maker

  def parse_requests(sock)

    request = sock.gets.chomp
    header_options = request.split(Protocole_communication::HEADSPLIT)
    puts header_options
    type = header_options.first
    puts type

    case type
      when 'upload'

        filename = header_options[1]
        filesize = header_options.last
        sock.puts('ready')
        Fly.download(sock, filename, filesize)

      when 'download'

        filename = header_options[1]
        outname = header_options.last
        filepath = "../Downloads/#{filename}"

        puts filename
        puts outname
        puts filepath

        send_up_request(sock, filepath, outname)

      else

        puts 'erreur'
    end

  end

  def forge_request(type, filename = 'TestVideoOriginal.mp4',  outname = 'TestVideoCopie.mp4')

    case type

      when 'upload'
        filesize = File.size("../Downloads/#{filename}")
        request = Protocole_communication.forge_header(type, outname, filesize)
        return request

      when 'download'
        request = Protocole_communication.forge_header(type, filename, outname)
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