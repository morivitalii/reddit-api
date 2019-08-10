# frozen_string_literal: true

module VotableDecorator
  extend ActiveSupport::Concern

  included do
    def up_vote_link
      up_voted = model.vote&.up?

      link_class = up_voted ? "up text-success mr-1p" : "up mr-1"
      link_icon = h.fa_icon("arrow-up")
      link_path = [model, :votes]
      link_data_params = up_voted ? "" : "create_vote_form[type]=up"
      link_method = up_voted ? :delete : :post

      h.link_to(link_icon, link_path, data: { params: link_data_params }, remote: true, method: link_method, class: link_class)
    end

    def score
      score = h.number_to_human(model.score, separator: ".", strip_insignificant_zeros: true, units: { thousand: "k" }, format: "%n%u")

      h.content_tag(:span, score, class: "score")
    end

    def down_vote_link
      down_voted = model.vote&.down?

      link_class = down_voted ? "down text-danger mr-1" : "down mr-1"
      link_icon = h.fa_icon("arrow-down")
      link_path = [model, :votes]
      link_data_params = down_voted ? "" : "create_vote_form[type]=down"
      link_method = down_voted ? :delete : :post

      h.link_to(link_icon, link_path, data: { params: link_data_params }, remote: true, method: link_method, class: link_class)
    end
  end
end