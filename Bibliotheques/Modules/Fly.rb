module Fly

  def download(sock, filename, filesize)

    puts 'start download'
    size = 1024 * 1024 * 10
    path = "../Telechargements/#{filename}"

    puts filesize

    current_size = 0
    time = Benchmark.realtime do
      File.open(path, 'w') do |file|
        while chunk = sock.read(size)
          current_size += chunk.size
          file.write(chunk)
          show_progress(filename,current_size ,filesize)
        end
      end
    end

    file_size = File.size(path) / 1024
    puts "Time elapsed: #{time}. Transferred #{file_size/1024} MB. Transfer per second: #{((file_size / 1024) / time).round(2)} MB/s" and exit

  end

  def upload(sock, filepath, filesize)

    size = 1024 * 1024 * 10
    current_size = 0
    splited_path = filepath.split('/')
    filename = splited_path.last

    temps = Benchmark.realtime do
      File.open(filepath, 'rb') do |file|
        while chunk = file.read(size)
          current_size += chunk.size
          sock.write(chunk)
          show_progress(filename, current_size, filesize, true)
        end
      end
    end

    puts "Time elapsed: #{temps}. Transferred #{(filesize/1024)/1024} MB. Transfer per second: #{(((filesize / 1024)/ 1024)/ temps).round(2)} MB/s" and exit

  end

  def show_progress(nom, current, total, upload=false)

    progress = (current.to_f/total.to_f).round(2)

    system('clear') or system('cls')

    upload ? puts("Upload de #{nom} :") : puts("Téléchargement de #{nom} :")

    case
      when progress >= 0.0 && progress < 0.1
        puts '#          # O%'
      when progress >= 0.1 && progress < 0.2
        puts '#=>        # 10%'
      when progress >= 0.2 && progress < 0.3
        puts '#==>       # 20%'
      when progress >= 0.3 && progress < 0.4
        puts '#===>      # 30%'
      when progress >= 0.4 && progress < 0.5
        puts '#====>     # 40%'
      when progress >= 0.5 && progress < 0.6
        puts '#=====>    # 50%'
      when progress >= 0.6 && progress < 0.7
        puts '#======>   # 60%'
      when progress >= 0.7 && progress < 0.8
        puts '#=======>  # 70%'
      when progress >= 0.8 && progress < 0.9
        puts '#========> # 80%'
      when progress >= 0.9 && progress < 1.0
        puts '#=========># 90%'
      when progress == 1.0
        puts '#==========# 100%'
      else
        puts 'Erreur... Cependant le téléchargement n\'en est pas affecté'
    end
  end

end