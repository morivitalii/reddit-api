# frozen_string_literal: true

class Post < ApplicationRecord
  include Paginatable
  include Scorable
  include Editable
  include Approvable
  include Deletable
  include Notifiable
  include Reportable
  include Votable
  include Bookmarkable
  include Uploader::Attachment.new(:media)

  belongs_to :sub
  belongs_to :user
  has_one :topic
  has_many :comments
  has_many :logs, as: :loggable
  
  scope :in_date_range, ->(date) { where("created_at > ?", date) if date.present? }

  before_create :normalize_url_on_create
  before_create :set_media_processing_attributes_on_media_cache
  before_update :reset_deletion_attributes_on_media_store
  after_create :create_topic_on_create

  validates :title, presence: true, length: { maximum: 350 }
  validates :tag, allow_blank: true, length: { maximum: 30 }

  with_options if: ->(r) { r.text.present? } do
    validates :text, presence: true, length: { maximum: 10_000 }
    validates :url, absence: true
    validates :media, absence: true
  end

  with_options if: ->(r) { r.url.present? } do
    validates :url, presence: true, length: { maximum: 2048 }
    validate :validate_url_domain_not_blacklisted, on: :create
    validates :text, absence: true
    validates :media, absence: true
  end

  with_options if: ->(r) { r.media.present? } do
    validates :media, presence: true
    validates :text, absence: true
    validates :url, absence: true
  end

  def title=(value)
    super(value.squish)
  end

  def tag=(value)
    super(value&.squish)
  end

  def text=(value)
    super(value.strip)
  end

  def presenter
    @presenter ||= ThingPresenter.new(self)
  end

  def youtube?
    @youtube ||= %w(youtube.com www.youtube.com youtu.be www.youtu.be).include?(URI(url).host)
  end

  def youtube_id
    @youtube_id ||= url.to_s.gsub(/(https?:\/\/)?(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\?\S+)?/) do
      Regexp.last_match(4).to_s
    end
  end

  def image?
    file[:original].type == "image"
  end

  def video?
    file[:original].type == "video"
  end

  def gif?
    file[:original].type == "gif"
  end

  def cut_text_preview?
    text.length > 800
  end

  def cut_image_preview?
    _, height = image_content_dimensions
    height > 550
  end

  def image_content_dimensions
    variant = :desktop

    if file[variant].height > 550
      coefficient_by_max_height = 550 / file[variant].height.to_f
      width_calculated_with_coefficient_by_max_height = (file[variant].width * coefficient_by_max_height).round

      if width_calculated_with_coefficient_by_max_height < 350
        coefficient_by_min_width = 350 / file[variant].width.to_f

        [(file[variant].width * coefficient_by_min_width).round, (file[variant].height * coefficient_by_min_width).round]
      else
        [width_calculated_with_coefficient_by_max_height, (file[variant].height * coefficient_by_max_height).round]
      end
    else
      [file[variant].width, file[variant].height]
    end
  end

  def html_text
    return @html_text if defined? (@html_text)

    markdown = Redcarpet::Markdown.new(
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

    @html_text = markdown.render(text)
  end

  private

  def validate_url_domain_not_blacklisted
    uri = Addressable::URI.parse(url).normalize

    if uri.present? && uri.host.present? && uri.scheme.in?(%w(http https))
      domain = uri.host.split(".").last(2).join(".")

      if BlacklistedDomain.where(sub: [sub, nil]).where("lower(domain) = ?", domain.downcase).exists?
        errors.add(domain, :blacklisted_domain)
      end
    else
      errors.add(:url, :invalid)
    end
  rescue StandardError
    errors.add(:url, :invalid)
  end

  def normalize_url_on_create
    return if url.blank?

    self.url = Addressable::URI.parse(self.url).normalize.to_s
  end

  def set_media_processing_attributes_on_media_cache
    return unless media.present? || (media_data_changed? && file_attacher.cached?)

    assign_attributes(deleted_by: user, deleted_at: Time.current)
  end

  def reset_deletion_attributes_on_media_store
    return unless media.present? || (media_data_changed? && file_attacher.stored?)

    reset_deletion_attributes
  end

  def create_topic_on_create
    create_topic!
  end
end