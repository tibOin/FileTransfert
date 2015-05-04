module Protocole_communication

########################################################################################################################
#                                                Constantes Protocole                                                  #
########################################################################################################################
  SPLITMARK = '°*°'
  HEADSPLIT = ':'


########################################################################################################################
#                                                  Création Paquet                                                     #
########################################################################################################################
  def forge_paquet(header, content='')

    if content != ''
      paquet = "#{header}#{SPLITMARK}#{content}"
    else
      paquet = "#{header}"
    end

    return paquet
  end

  def forge_header(type, nom_fichier='', taille_fichier='')

    case type
      when 'upload'
        header = "#{type}#{HEADSPLIT}#{nom_fichier}#{HEADSPLIT}#{taille_fichier}"
      when 'download'
        header = "#{type}#{HEADSPLIT}#{nom_fichier}#{HEADSPLIT}#{taille_fichier}"
      else
        return 'error'
    end

    return header
  end

########################################################################################################################
#                                                    Lecture Paquet                                                    #
########################################################################################################################
  def split_paquet(paquet)

    header, content = paquet.split(SPLITMARK)

    if content == ''
      return header
    else
      return header, content
    end

  end

  def split_header(header)
    header_options = header.split(HEADSPLIT)
    return header_options
  end


end