# frozen_string_literal: true

class MarkdownRenderer < Redcarpet::Render::HTML
  def double_emphasis(text)
    %(<b>#{text}</b>)
  end

  def triple_emphasis(text)
    %(<em><b>#{text}</b></em>)
  end
end
