require_relative 'ja/version'
require_relative 'ja/converter'

require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include Asciidoctor

Extensions.register do
  treeprocessor do

    process do |document|
      paragraphs = document.find_by context: :paragraph
      paragraphs.each do |paragraph|
        paragraph.lines.each_with_index do |line, i|
          modified = Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space(line)
          paragraph.lines[i] = Asciidoctor::Pdf::Linewrap::Ja::Converter::remove_zero_width_space(modified)
        end
      end

      list_items = document.find_by context: :list_item
      list_items.each do |list_item|
        list_item.text = Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space(list_item.text)
      end
    end
  end
end
