# frozen_string_literal: true

class BlacklistedDomainsQuery
  attr_reader :relation

  def initialize(relation = BlacklistedDomain.all)
    @relation = relation
  end

  def sub(sub)
    relation.where(sub: sub)
  end

  def global
    relation.where(sub: nil)
  end

  def global_or_sub(sub)
    sub_condition = relation.model.where(sub: sub)

    relation.where(sub: nil).or(sub_condition)
  end

  def filter_by_domain(domain)
    return relation if domain.blank?

    relation.where("lower(domain) = ?", domain)
  end
end