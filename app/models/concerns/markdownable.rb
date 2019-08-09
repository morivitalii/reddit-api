# frozen_string_literal: true

module Markdownable
  extend ActiveSupport::Concern

  included do
    def self.markdown_attributes(*attributes)
      attributes.each do |attribute|
        define_method :"#{attribute}_html" do
          markdown_to_html(attribute)
        end
      end
    end

    private

    def markdown_to_html(attribute)
      variable_name = "@_#{attribute}_html"

      return instance_variable_get(variable_name) if instance_variable_defined?(variable_name)

      instance_variable_set(variable_name, markdown_renderer.render(self[attribute]))
      instance_variable_get(variable_name)
    end

    def markdown_renderer
      Redcarpet::Markdown.new(
        MarkdownRenderer.new(
          escape_html: true,
          hard_wrap: true,
          no_images: true,
          link_attributes: { rel: "nofollow", target: "_blank" },
          space_after_headers: true,
          fenced_code_blocks: true,
          safe_links_only: true
        ),
        autolink: true,
        tables: true,
        superscript: true,
        strikethrough: true,
        disable_indented_code_blocks: true
      )
    end
  end
end

class MarkdownRenderer < Redcarpet::Render::HTML
  def double_emphasis(text)
    %(<b>#{text}</b>)
  end

  def triple_emphasis(text)
    %(<em><b>#{text}</b></em>)
  end
end