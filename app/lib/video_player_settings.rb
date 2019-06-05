# frozen_string_literal: true

class VideoPlayerSettings
  class << self
    def video(duration)
      {
          controls: ["play-large", "play", "progress", "current-time", "mute", "volume", "settings", "fullscreen"],
          duration: duration
      }.to_json
    end

    def gif(duration)
      {
          controls: ["play-large", "play", "fullscreen"],
          duration: duration,
          loop: { active: true }
      }.to_json
    end
  end
end
