class Communities::CreatePost
  include ActiveModel::Model

  attr_accessor :community, :created_by, :title, :text, :file, :explicit, :spoiler
  attr_reader :post

  def call
    ActiveRecord::Base.transaction do
      @post = community.posts.new(
        created_by: created_by,
        title: title,
        text: text,
        file: file,
        explicit: explicit,
        spoiler: spoiler
      )

      if author_has_permissions_to_approve?(post)
        post.assign_attributes(
          approved_by: created_by,
          approved_at: Time.current
        )
      end

      post.save!
      post.create_topic!
      post.votes.create!(vote_type: :up, user: created_by)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end

  private

  def author_has_permissions_to_approve?(post)
    context = Context.new(created_by, community)
    Api::Communities::Posts::ApprovePolicy.new(context, post).update?
  end
end
