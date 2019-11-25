class Communities::Posts::CreateForm
  include ActiveModel::Model

  attr_accessor :community, :user, :title, :text, :url, :image, :explicit, :spoiler
  attr_reader :post

  def save
    ActiveRecord::Base.transaction do
      @post = community.posts.create!(
        user: user,
        title: title,
        text: text,
        url: url,
        image: image,
        explicit: explicit,
        spoiler: spoiler
      )

      post.votes.create!(vote_type: :up, user: user)
    end
  rescue ActiveRecord::RecordInvalid => invalid
    errors.merge!(invalid.record.errors)

    false
  end
end
