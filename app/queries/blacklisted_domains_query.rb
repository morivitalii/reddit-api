# frozen_string_literal: true

class BlacklistedDomainsQuery < ApplicationQuery
  def with_domain(domain)
    relation.where("lower(domain) = ?", domain)
  end

  def search_by_domain(domain)
    return relation if domain.blank?

    with_domain(domain)
  end
end