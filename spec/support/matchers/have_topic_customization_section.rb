module RSpec
  module Matchers
    class HaveTopicCustomizationSection
      include RSpec::Matchers

      def initialize(topic, *indices)
        @topic = topic
        @indices = indices
      end

      def topic_selector
        id = @topic.name.downcase.gsub(/[^a-z0-9]/, '-')
        '#' + id + '-section'
      end

      def matches?(page)
        return false unless has_topic?(page)

        page.within(topic_selector) do
          # check for presence of topic title as a heading
          has_topic_title?(page)

          # check for presence of every section in this topic
          # - if indices have been provided, only check for presence of those
          #   topics
          @topic.sections.each_with_index do |section, idx|
            if @indices.empty? || @indices.include?(idx)
              has_section?(page, section, idx)
            end
          end
        end

        # if RSpec did not raise any errors yet, we are golden :)
        return true
      end

      private

      def has_topic?(page)
        expect(page).to have_selector(topic_selector)
      end

      def has_topic_title?(page)
        expect(page).to have_selector('h2.section-title',
                                      text: @topic.sanitized_name)
      end

      def has_section?(page, section, index)
        # check for presence of code for this section
        has_highlighted_code_for_section?(page, section)

        # check for presence of sectional headings (can be multiple/section)
        has_headings_for_section?(page, section)

        # check for presence of checkbox for this particular section
        has_checkbox_for_section_with_index?(page, index)
      end

      def has_highlighted_code_for_section?(page, section)
        # remove line numbers from HTML
        page.all('pre .lineno').map { |a| a.native.remove }

        # remove any whitespace as that may have changed
        matched = page.all('pre').detect do |code|
          code.text.gsub(/\s+/m, '') == section.content.gsub(/\s+/m, '')
        end

        expect(matched).not_to be_nil
      end

      def has_headings_for_section?(page, section)
        section.headings.each do |heading|
          expect(page).to have_content(heading.titleize)
        end
      end

      def has_checkbox_for_section_with_index?(page, index)
        id = "[sections][#{@topic.id * 1000 + index}]"
        selector = "input[type='checkbox'][name='#{id}']"
        expect(page).to have_selector(selector)
      end
    end

    def have_topic_customization_section(topic)
      HaveTopicCustomizationSection.new(topic)
    end
  end
end
