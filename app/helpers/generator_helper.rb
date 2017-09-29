# Helper methods defined here can be accessed in any controller or view in the application

module Vimspec
  class App
    module GeneratorHelper
      def list_vim_configs(type = nil)
        pattern = File.join(Padrino.root, "app", "vimrc", "*.vim")
        configs = Dir.glob(pattern).map{|f| File.basename(f, '.vim')}
        configs = configs.map{ |config| config.gsub(/^\d+_?/, '').downcase }
        configs = configs.sort.reverse

        return configs unless type
        configs.select do |config|
          comments_for(config)[0] =~ /^\"\s+-->\s+action:.*#{type}/mi
        end
      end

      def list_optional_vim_configs
        list_vim_configs.reject do |config|
          comments_for(config)[0] =~ /^\"\s+-->\s+.*REQUIRE/
        end
      end

      def vim_config_for(name)
        name = "*#{name.to_s.downcase}.vim"
        pattern = File.join(Padrino.root, "app", "vimrc", name)
        Dir.glob(pattern).first
      end
      def has_vim_config?(name)
        !!vim_config_for(name)
      end
      def load_vim_config(name)
        return unless has_vim_config?(name)
        File.read(vim_config_for(name))
      end

      def show_vim_config(name, required: false)
        return if !has_vim_config?(name)
        return if !required && !params[name.to_sym] && !params[:all]
        config = load_vim_config(name)
        config = config.gsub(/^\"\s*-->\s*\w+\:\s+.*?$/m, '')

        "\" #{name.to_s.humanize.upcase} {{{\n#{config.strip}\n\" }}}\n".html_safe
      end

      def comments_for(name)
        load_vim_config(name).to_s.lines.select do |l|
          l =~ /^\"\s+-->\s+/
        end
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
