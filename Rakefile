require 'bundler/setup'
require 'padrino-core/cli/rake'

PadrinoTasks.init

# desc "Parse"
# task parse: :environment do
#   sections = VimRCG::ConfigParser.list

#   sections = sections.map do |config|
#     config.map.with_index do |section, idx|
#       section.to_h.merge(
#         path: config.path,
#         index: config.index * 1000 + idx + 1,
#         parent: config.name,
#         metadata: config.metadata,
#       )
#     end
#   end

#   sections = sections.flatten.map do |section|
#     idx  = "%05d" % section[:index]
#     data = Base64.encode64(section.to_json)
#     [idx, data]
#   end.to_h

#   path = File.join(Padrino.root, "sections", "v#{APP_VERSION}.yml")
#   File.open(path, "w"){|f| f.puts sections.to_yaml}
# end

task default: :test
