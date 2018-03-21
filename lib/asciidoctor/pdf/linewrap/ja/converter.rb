module Asciidoctor
  module Pdf
    module Linewrap
      module Ja
        module Converter

          # 行頭禁則文字
          PROHIBIT_LINE_BREAK_BEFORE =
            '｝〕〉》」』】〙〗〟｠»' +
            'ゝゞーァィゥェォッャュョヮヵヶぁぃぅぇぉっゃゅょゎゕゖㇰㇱㇲㇳㇴㇵㇶㇷㇸㇹㇷ゚ㇺㇻㇼㇽㇾㇿ々〻' +
            'ｧｨｩｪｫｯｬｭｮ' +
            '‐゠〜～' +
            '‼⁇⁈⁉' +
            '？！' +
            '・' +
            '、。'

          # 行末禁則文字
          PROHIBIT_LINE_BREAK_AFTER = '｛〔〈《「『【〘〖〝｟«'

          # 分離禁止文字
          PROHIBIT_DIVIDE = '…‥〳〴〵'

          # ゼロ幅スペース
          ZERO_WIDTH_SPACE = '{zwsp}'

          def self.insert_zero_width_space(line)

            new_line = ''

            line.each_char.with_index do |ch, idx|

              new_line << ch
              new_line << ZERO_WIDTH_SPACE if insert_zero_width_space?(ch, line[idx + 1])
            end

            return new_line
          end

          def self.insert_zero_width_space?(ch, next_ch)
            japanese_char?(ch) \
              && !PROHIBIT_LINE_BREAK_AFTER.include?(ch) \
              && next_ch != nil && !PROHIBIT_LINE_BREAK_BEFORE.include?(next_ch) \
              && !(PROHIBIT_DIVIDE.include?(ch) && PROHIBIT_DIVIDE.include?(next_ch))
          end

          def self.japanese_char?(ch)
            (/[\p{Han}\p{Hiragana}\p{Katakana}ー]/ === ch) \
              || PROHIBIT_LINE_BREAK_BEFORE.include?(ch) \
              || PROHIBIT_LINE_BREAK_AFTER.include?(ch) \
              || PROHIBIT_DIVIDE.include?(ch)
          end
        end
      end
    end
  end
end
