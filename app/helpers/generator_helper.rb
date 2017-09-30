module VimRCG
  class App
    module GeneratorHelper
      def topic_list
        TopicList.from_params(params)
      end

      def highlight(code, opts = {})
        opts = { linenos: :inline, encoding: 'utf-8' }.merge(opts)
        Pygments.highlight(code, lexer: :vim, options: opts).html_safe
      end

      def display_topic(list, name)
        topic = list.fetch_topic(name)
        return unless topic
        partial 'generator/topic', locals: { topic: topic }
      end
    end

    helpers GeneratorHelper
  end
end
