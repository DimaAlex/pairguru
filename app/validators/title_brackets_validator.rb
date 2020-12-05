# frozen_string_literal: true

class TitleBracketsValidator < ActiveModel::Validator
  BRACKETS = { '{' => '}', '[' => ']', '(' => ')' }.freeze

  def validate(record)
    return record.errors[:title] << 'value should be String' unless record.title.is_a? String

    unless opened_brackets?(record.title)
      record.errors[:title] << 'There are opened or empty brackets'
    end
  end

  private

  def opened_brackets?(title)
    title.each_char.with_index.with_object([]) do |char_with_index, opened_brackets|
      char, index = *char_with_index
      opened_brackets << char && next if BRACKETS.key?(char)

      BRACKETS.key(char).yield_self do |opened_bracket|
        if opened_bracket && (empty_brackets?(title, index) || opened_bracket != opened_brackets.pop)
          return false
        end
      end
    end.empty?
  end

  def empty_brackets?(title, index)
    BRACKETS.key?(title[index - 1])
  end
end
