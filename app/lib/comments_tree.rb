# frozen_string_literal: true

class CommentsTree
  include ActiveModel::Model

  attr_reader :post, :comment, :branch

  def initialize(params)
    @thing = params[:thing]
    @sort = params[:sort]
    @after = params[:after]
    @initial_limit = 50
    @load_more_limit = 50
    @level_limit = Current.variant.desktop? ? 10 : 4
    @nested_limit = 100
    @per_nested_limit = 10
    @nested_count = 0
  end

  def build
    @branch = @thing.post? ? @thing.topic.branch : @thing.post.topic.branch
    @branch = @branch.with_indifferent_access.values

    # TODO: оптимизировать
    @branch.reject! { |i| i[:deleted] && have_only_deleted_nested?(i[:id]) }
    @branch = sort(@branch)

    if @thing.post?
      @branch = collect_nested({ id: @thing.id }, 0)
    else
      @branch = { id: @thing.post_id, nested: [collect_nested({ id: @thing.id }, 0)] }
    end

    query = Thing.where(id: collect_ids(@branch)).includes(:sub, :user, :deleted_by)

    @things = query.all

    @branch = set_nested(@branch)
    @post = @branch[:thing]

    if @thing.comment?
      @comment = @branch[:nested].first[:thing]
    end

    itself
  end

  private

  def have_only_deleted_nested?(id)
    nested = @branch.find_all { |i| id == i[:thing_id] }
    nested.present? ? nested.map { |i| i[:deleted] && have_only_deleted_nested?(i[:id]) }.uniq == [true] : true
  end

  def sort(branch)
    case @sort
    when :hot then branch.sort { |a, b| a.dig(:scores, :hot_score) == b.dig(:scores, :hot_score) ? a[:id] <=> b[:id] : b.dig(:scores, :hot_score) <=> a.dig(:scores, :hot_score) }
    when :best then branch.sort { |a, b| a.dig(:scores, :best_score) == b.dig(:scores, :best_score) ? a[:id] <=> b[:id] : b.dig(:scores, :best_score) <=> a.dig(:scores, :best_score) }
    when :top then branch.sort { |a, b| a.dig(:scores, :top_score) == b.dig(:scores, :top_score) ? a[:id] <=> b[:id] : b.dig(:scores, :top_score) <=> a.dig(:scores, :top_score) }
    when :controversy then branch.sort { |a, b| a.dig(:scores, :controversy_score) == b.dig(:scores, :controversy_score) ? a[:id] <=> b[:id] : b.dig(:scores, :controversy_score) <=> a.dig(:scores, :controversy_score) }
    when :new then branch.sort { |a, b| a.dig(:scores, :new_score) == b.dig(:scores, :new_score) ? b[:id] <=> a[:id] : b.dig(:scores, :new_score) <=> a.dig(:scores, :new_score) }
    when :old then branch.sort { |a, b| a.dig(:scores, :new_score) == b.dig(:scores, :new_score) ? a[:id] <=> b[:id] : a.dig(:scores, :new_score) <=> b.dig(:scores, :new_score) }
    end
  end

  def collect_nested(parent, level)
    if level < @level_limit
      limit = if level.zero?
                @after.present? ? @load_more_limit : @initial_limit
              else
                if @nested_count + @per_nested_limit > @nested_limit
                  if @nested_limit - @nested_count <= 0
                    3
                  else
                    @nested_limit - @nested_count
                  end
                else
                  @per_nested_limit
                end
              end

      nested = @branch.find_all { |i| i[:thing_id] == parent[:id] }
      if @after.present? && after_index = nested.index { |i| i[:id] == @after.id }
        start_index = after_index + 1
        end_index = after_index + limit
      else
        start_index = 0
        end_index = limit - 1
      end

      parent[:nested] = nested[start_index..end_index]
      parent[:load_more] = nested[end_index + 1..-1].present?
      parent[:load_more_size] = parent[:load_more] ? nested[end_index + 1..-1].size : nil
      parent[:load_more_after] = parent[:load_more] ? parent[:nested].last[:id] : nil
      parent[:deeper] = nested.present? && nested[end_index + 1..-1].present? && level > 0

      @nested_count += parent[:nested].size

      parent[:nested].each do |parent|
        collect_nested(parent, level + 1)
      end
    else
      parent[:nested] = []
      parent[:deeper] = @branch.find { |i| i[:thing_id] == parent[:id] }.present?
    end

    parent
  end

  def collect_ids(item)
    [item[:id]] + item[:nested].map { |i| collect_ids(i) }.flatten
  end

  def set_nested(item)
    item[:thing] = @things.find { |i| item[:id] == i.id }

    item[:nested].each do |item|
      set_nested(item)
    end

    item
  end
end
