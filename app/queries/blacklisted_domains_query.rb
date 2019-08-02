# frozen_string_literal: true

class BlacklistedDomainsQuery
  attr_reader :relation

  def initialize(relation = BlacklistedDomain.all)
    @relation = relation
  end

  def where_sub(sub)
    relation.where(sub: sub)
  end

  def where_global
    relation.where(sub: nil)
  end

  def where_global_and_sub(sub)
    relation.where(sub: [nil, sub])
  end

  def filter_by_domain(domain)
    return relation if domain.blank?

    relation.where("lower(domain) = ?", domain)
  end
end