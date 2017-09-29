module Vimspec
  class App
    module GeneratorHelper
      def read_configs
        return @configs if @configs
        pattern = File.join(Padrino.root, "app", "vimrc", "*.vim")
        @configs = Dir.glob(pattern).map do |file|
          [File.basename(file, ".vim"), File.read(file) ]
        end.sort_by(&:first).map do |item|
          [item[0].gsub(/^\d+_?/, '').downcase, item[1]]
        end.select{|item| item[1].lines.any?{|l| l=~/^[a-z0-9]+/mi}}
        @configs = Hash[@configs]
      end

      def config_list_for(type = :action, name = nil)
        return [] unless type and name
        read_configs.select do |config, str|
          str.lines[0] =~ /^\"\s+-->\s+#{type}:.*#{name}/mi
        end
      end

      def config_for(name)
        read_configs[name.to_s.downcase]
      end

      def comments_for(name)
        config_for(name).to_s.lines.select{ |l| l =~ /^\"\s+-->\s+/ }
      end

      def display_config(name, required: false)
        return if !required && !params[name.to_sym] && !params[:all]
        return unless config_for(name)

        config = config_for(name).gsub(/^\"\s*-->\s*\w+\:\s+.*?$/m, '')
        locals = { name: name.to_s.humanize.upcase, config: config }
        partial("generator/config", locals: locals).strip.html_safe
      end

      def display_config_group(name, options = {})
        locals = { check: false, disabled: false }
        locals = locals.merge(options).merge(type: name)
        partial "generator/config_group", locals: locals
      end
    end

    helpers GeneratorHelper
  end
end
