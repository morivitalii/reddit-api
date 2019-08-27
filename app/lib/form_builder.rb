# frozen_string_literal: true

class FormBuilder < ActionView::Helpers::FormBuilder
  def text_field(method, options = {})
    @template.content_tag(:div, class: "form-group") do
      if @object.present?
        @template.concat(
          @template.content_tag(:label, for: "#{@object_name}_#{method}") do
            @object.class.human_attribute_name(method)
          end
        )
      end

      classes = options[:class].is_a?(String) ? [options[:class]] : options[:class].to_a
      options[:class] = Array.new(classes).push("form-control")

      @template.concat(
        @template.text_field(@object_name, method, objectify_options(options))
      )
    end
  end

  def text_area(method, options = {})
    @template.content_tag(:div, class: "form-group") do
      if options[:label] != false
        @template.concat(
          @template.content_tag(:label, for: "#{@object_name}_#{method}") do
            @object.class.human_attribute_name(method)
          end
        )
      end

      classes = options[:class].is_a?(String) ? [options[:class]] : options[:class].to_a
      options[:class] = Array.new(classes).push("form-control")
      options[:rows] ||= 5

      @template.concat(
        @template.text_area(@object_name, method, objectify_options(options))
      )
    end
  end

  def check_box(method, options = {})
    @template.content_tag(:div, class: "form-group") do
      @template.content_tag(:div, class: "custom-control custom-checkbox") do
        classes = options[:class].is_a?(String) ? [options[:class]] : options[:class].to_a
        options[:class] = Array.new(classes).push("custom-control-input")

        @template.concat(
          @template.check_box(@object_name, method, objectify_options(options))
        )

        @template.concat(
          @template.content_tag(:label, class: "custom-control-label", for: "#{@object_name}_#{method}") do
            @object.class.human_attribute_name(method)
          end
        )
      end
    end
  end

  def password_field(method, options = {})
    @template.content_tag(:div, class: "form-group") do
      @template.concat(
        @template.content_tag(:label, for: "#{@object_name}_#{method}") do
          @object.class.human_attribute_name(method)
        end
      )

      classes = options[:class].is_a?(String) ? [options[:class]] : options[:class].to_a
      options[:class] = Array.new(classes).push("form-control")

      @template.concat(
        @template.password_field(@object_name, method, objectify_options(options))
      )
    end
  end

  # def file_field(method, options = {})
  #   @template.content_tag(:div, class: "form-group") do
  #     classes = options[:class].is_a?(String) ? [options[:class]] : options[:class].to_a
  #     options[:class] = Array.new(classes).push("form-control-file")
  #
  #     @template.concat(
  #       @template.file_field(@object_name, method, objectify_options(options))
  #     )
  #   end
  # end

  def submit(value, options = {})
    classes = options[:class].is_a?(String) ? [options[:class]] : options[:class].to_a
    options[:class] = Array.new(classes).push("btn btn-primary")
    @template.submit_tag(value, options)
  end
end
