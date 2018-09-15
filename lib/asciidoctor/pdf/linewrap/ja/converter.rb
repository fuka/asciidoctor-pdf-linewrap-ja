module Asciidoctor
  module Pdf
    module Linewrap
      module Ja
        module Converter

          # 行頭禁則文字
          PROHIBIT_LINE_BREAK_BEFORE =
            '）｝〕〉》」』】〙〗〟｠»' +
            'ゝゞーァィゥェォッャュョヮヵヶぁぃぅぇぉっゃゅょゎゕゖㇰㇱㇲㇳㇴㇵㇶㇷㇸㇹㇷ゚ㇺㇻㇼㇽㇾㇿ々〻' +
            'ｧｨｩｪｫｯｬｭｮ' +
            '‐゠〜～' +
            '‼⁇⁈⁉' +
            '？！' +
            '・' +
            '、。'

          # 行頭禁則文字（半角）
          PROHIBIT_LINE_BREAK_BEFORE_HALF_WIDTH =
            ')]>}' +
            '-=~' +
            '?!'

          # 行末禁則文字
          PROHIBIT_LINE_BREAK_AFTER = '（｛〔〈《「『【〘〖〝｟«'

          # 行末禁則文字（半角）
          PROHIBIT_LINE_BREAK_AFTER_HALF_WIDTH = '([<{'

          # 分離禁止文字
          PROHIBIT_DIVIDE = '…‥〳〴〵'

          # ゼロ幅スペース
          ZERO_WIDTH_SPACE = '{zwsp}'
          # ZERO_WIDTH_SPACE = '★'

          def self.insert_zero_width_space(line)

            new_line = ''

            line.each_char.with_index do |ch, idx|

              new_line << ch
              new_line << ZERO_WIDTH_SPACE if insert_zero_width_space?(ch, line[idx + 1])
            end

            return remove_zero_width_space(new_line)
          end

          def self.insert_zero_width_space?(ch, next_ch)

            if japanese_char?(ch)
              return !prohibit_line_break?(ch, next_ch)
            elsif next_ch != nil && japanese_char?(next_ch)
              return !prohibit_line_break_before?(next_ch)
            end

            return false
          end

          def self.remove_zero_width_space(line)
            line.gsub(/http.*?[\]\s]/) do |href|
              href.gsub(/#{ZERO_WIDTH_SPACE}/, "")
            end
          end

          def self.japanese_char?(ch)
            (/[\p{Han}\p{Hiragana}\p{Katakana}ー]/ === ch) \
            || PROHIBIT_LINE_BREAK_BEFORE.include?(ch) \
            || PROHIBIT_LINE_BREAK_AFTER.include?(ch) \
            || PROHIBIT_DIVIDE.include?(ch)
          end

          def self.prohibit_line_break?(ch, next_ch)
            prohibit_line_break_after?(ch) || prohibit_line_break_before?(next_ch) || prohibit_divide?(ch, next_ch)
          end

          def self.prohibit_line_break_after?(ch)
            PROHIBIT_LINE_BREAK_AFTER.include?(ch) || PROHIBIT_LINE_BREAK_AFTER_HALF_WIDTH.include?(ch)
          end

          def self.prohibit_line_break_before?(ch)
            ch == nil || PROHIBIT_LINE_BREAK_BEFORE.include?(ch) || PROHIBIT_LINE_BREAK_BEFORE_HALF_WIDTH.include?(ch)
          end

          def self.prohibit_divide?(ch, next_ch)
            next_ch == nil || (PROHIBIT_DIVIDE.include?(ch) && PROHIBIT_DIVIDE.include?(next_ch))
          end
        end
      end
    end
  end
end
