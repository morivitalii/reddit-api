# frozen_string_literal: true

namespace :cleanup do |namespace|
  desc "Run all cleanup tasks"
  task all: :environment do
    namespace.tasks.each do |task|
      Rake::Task[task].invoke
    end
  end
end
