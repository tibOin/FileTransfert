require_relative '../Bibliotheques/Modules/Requester'

incoming = "upload:filename:filesize"

opt = Request_maker.parse_request(incoming)

puts "#{opt}"

puts "opt[0] = #{opt[0]}"
puts "opt[1] = #{opt[1]}"
puts "opt[2] = #{opt[2]}"
