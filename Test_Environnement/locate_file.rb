def locateHost()

    rb = Dir.glob('Downloads/*.*')

    rb.each do |filename|

      puts filename
     # fichier = File.open(filename, 'a+')

      #infect(fichier)

    end

  end

locateHost()
