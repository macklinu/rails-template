def add_gems
  gem "devise"
  gem "strong_migrations"

  development_and_test_gems = <<-RUBY
  gem "awesome_print"
  gem "bullet"
  gem "faker"
  gem "standard"
  RUBY

  inject_into_file(
    "Gemfile",
    development_and_test_gems,
    after: "group :development, :test do\n"
  )
end

def setup_prettier
  run "yarn add --dev prettier"

  copy_file ".prettierrc"
end

def setup_git_commit_hooks
  copy_file ".lintstagedrc.json"
  run "yarn add -D husky lint-staged"
  run 'npm pkg set scripts.prepare="husky install"'
  run "yarn run prepare"
  run 'npx husky add .husky/pre-commit "npx lint-staged"'
end

def setup_tailwind
  run "yarn add -D @tailwindcss/typography @tailwindcss/forms @tailwindcss/aspect-ratio @tailwindcss/line-clamp"

  copy_file "tailwind.config.js"
end

def setup_strong_migrations
  generate "strong_migrations:install"
end

def setup_devise
  generate "devise:install"

  generate :controller, "Home", "index", "--skip-routes"

  environment "config.action_mailer.default_url_options = {host: 'localhost', port: 3000}",
    env: "development"

  route "root to: 'home#index'"

  generate :devise, "User", "first_name", "last_name", "admin:boolean"

  in_root do
    migration = latest_migration_file
    gsub_file migration, /:first_name/, ":first_name, null: false"
    gsub_file migration, /:last_name/, ":last_name, null: false"
    gsub_file migration, /:admin/, ":admin, null: false, default: false"
  end

  generate "devise:views"
end

def setup_standard
  copy_file ".rubocop.yml"
end

def setup_bullet
  generate "bullet:install"
end

def configure_generators
  # https://www.codewithjason.com/get-rspec-skip-view-specs-generate-scaffolds/
  config = <<-RUBY
    config.generators do |generator|
      generator.orm :active_record, primary_key_type: :uuid

      generator.assets false
      generator.helper false
      generator.stylesheets false

      generator.test_framework :rspec,
        view_specs: false,
        routing_specs: false,
        helper_specs: false,
        request_specs: false,
        controller_specs: false
    end
  RUBY

  inject_into_file(
    "config/application.rb",
    config,
    after: "class Application < Rails::Application\n"
  )
end

def create_uuid_migration
  generate "migration", "EnableUUID"

  inject_into_file(
    latest_migration_file,
    "enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')",
    after: "def change\n"
  )
end

def latest_migration_file
  Dir.glob("db/migrate/*").max_by { |f| File.mtime(f) }
end

add_gems

after_bundle do
  copy_file ".editorconfig"

  setup_git_commit_hooks
  setup_prettier
  setup_standard
  setup_tailwind

  configure_generators
  setup_strong_migrations
  create_uuid_migration
  setup_devise
  setup_bullet

  rails_command "db:create"
  rails_command "db:migrate"

  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
end

def source_paths
  [__dir__]
end
