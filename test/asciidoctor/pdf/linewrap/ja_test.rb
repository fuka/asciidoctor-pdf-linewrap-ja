require "test_helper"

class Asciidoctor::Pdf::Linewrap::JaTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Asciidoctor::Pdf::Linewrap::Ja::VERSION
  end

  def test_url
    result = Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space('http://www.example.com')
    assert_equal("http://www.example.com", result)
  end

  def test_insert_zero_width_space_nil
    # nilが来たらnilをそのまま返す
    assert_nil Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space(nil)
  end

  def test_japanese_char_hiragana
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('あ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ん')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ば')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ぱ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ぁ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('っ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ゑ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ー')
  end

  def test_japanese_char_katakana
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ア')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ン')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('バ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('パ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ァ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ッ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ヱ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ー')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ｱ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ﾝ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ｯ')
  end

  def test_japanese_char_kanji
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('一')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('龠')
  end

  def test_japanese_char_alphabet
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('A')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('a')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('Ａ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('ａ')
  end

  def test_japanese_char_number
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('1')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('0')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('１')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('０')
  end

  def test_japanese_char_punctuation_full_width
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('、')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('。')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('！')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('？')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('…')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('‥')
  end

  def test_japanese_char_symbol_full_width
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('「')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('」')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('『')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('』')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('【')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::japanese_char?('】')
  end

  def test_insert_zero_width_space_hiragana
    # 次がひらがな、カタカナ、漢字、アルファベット、数字なので挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', 'あ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', 'ア')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '亜')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', 'A')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', 'Ａ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '1')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '１')

    # 次に行頭禁則文字が来るときは挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '’')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '‐')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '！')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '・')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '。')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '、')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', 'ヽ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', 'ー')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', 'ぁ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '）')

    # 次に行末禁則文字が来るときは挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '‘')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '（')

    # 次に分離禁止文字が来るときは挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '—')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '…')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', '‥')

    # 次がnilの場合は文の最後尾なので挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('あ', nil)
  end

  def test_insert_zero_width_space_prohibit_line_break_before
    # 次がひらがな、カタカナ、漢字、アルファベット、数字なので挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', 'あ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', 'ア')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '亜')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', 'A')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', 'Ａ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '1')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '１')

    # 次に行頭禁則文字が来るときは挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '’')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '‐')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '！')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '・')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '。')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '、')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', 'ヽ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', 'ー')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', 'ぁ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '）')

    # 次に行末禁則文字が来るときは挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '‘')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '（')

    # 次に分離禁止文字が来るときは挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '—')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '…')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', '‥')

    # 次がnilの場合は文の最後尾なので挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('っ', nil)
  end

  def test_insert_zero_width_space_prohibit_line_break_after
    # 行末禁則文字なので、次の文字種に関わらず挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', 'あ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', 'ア')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '亜')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', 'A')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', 'Ａ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '1')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '１')

    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '’')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '‐')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '！')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '・')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '。')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '、')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', 'ヽ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', 'ー')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', 'ぁ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '）')

    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '‘')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '（')

    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '—')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '…')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', '‥')

    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('「', nil)
  end

  def test_insert_zero_width_space_prohibit_divide
    # 次がひらがな、カタカナ、漢字、アルファベット、数字なので挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', 'あ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', 'ア')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '亜')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', 'A')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', 'Ａ')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '1')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '１')

    # 次に行頭禁則文字が来るときは挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '’')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '‐')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '！')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '・')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '。')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '、')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', 'ヽ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', 'ー')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', 'ぁ')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '）')

    # 次に行末禁則文字が来るときは挿入可
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '‘')
    assert Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '（')

    # 次に分離禁止文字が来るときは挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '—')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '…')
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', '‥')

    # 次がnilの場合は文の最後尾なので挿入不可
    refute Asciidoctor::Pdf::Linewrap::Ja::Converter::insert_zero_width_space?('‥', nil)
  end
end
