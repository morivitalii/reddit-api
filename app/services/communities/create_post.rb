class Communities::CreatePost
  include ActiveModel::Model

  attr_accessor :community, :created_by, :title, :text, :file, :explicit, :spoiler
  attr_reader :post

  def call
    ActiveRecord::Base.transaction do
      @post = community.posts.create!(
        created_by: created_by,
        title: title,
        text: text,
        file: file,
        explicit: explicit,
        spoiler: spoiler
      )

      post.create_topic!
      post.votes.create!(vote_type: :up, user: created_by)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
