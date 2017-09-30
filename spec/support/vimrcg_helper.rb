module VimRCG
  module RSpecHelper
    def config_fixture_path(name)
      File.join(Padrino.root, 'spec', 'fixtures', 'vimrc', "#{name}.vim")
    end

    def topic_for(name, exist = true)
      file = config_fixture_path(name)
      if block_given?
        content = exist ? yield(File.read(file)) : yield
        allow(File).to receive(:read).and_return content
      end
      Topic.new(file)
    end

    def topics_present?(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      args.each do |name|
        regex = /^\"\s+#{name}\s+\{\{\{\n.+?^\"\s+\}\}\}/m
        expectation = options.fetch(:negate, false) ? :not_to : :to
        expect(page.body).send(expectation, match(regex))
      end
    end

    def topics_absent?(*args)
      topics_present?(*args, negate: true)
    end

    def list_headers
      page.body.scan(/^\" -->.*?$/)
    end
  end
end
