require "bundler/gem_tasks"

root = File.expand_path("../", __FILE__)
subprojects = %w(adhoq-core adhoq-rails)

subprojects.each do |prj|
  namespace prj do
    desc "Run specs of #{prj}"
    task :spec do
      Bundler.with_clean_env do
        Dir.chdir(File.join(root, prj))
        bundle_gemfile = ENV["RAILS_VERSION"] ?
          "gemfiles/Gemfile-rails-#{ENV["RAILS_VERSION"]}.x" :
          "./Gemfile"
        sh "BUNDLE_GEMFILE=#{bundle_gemfile} bundle install --jobs=3 --retry=3 --path=.bundle"
        sh "BUNDLE_GEMFILE=#{bundle_gemfile} bundle exec rake spec"
      end
    end
  end
end

spec_target = ENV["SUBPROJECT"] || "adhoq-core"
desc "Run specs selected by ENV['SUBPROJECT'] (default adhoq-core)"
task spec: ["#{spec_target}:spec"]

task default: :spec
