# rails-template

> My preferred template for getting Started with a Rails application

What's in the box?

- [Devise](https://github.com/heartcombo/devise) for user authentication
- Tailwind for CSS
- PostgreSQL database
- esbuild for bundling JS assets
- [RSpec](https://github.com/rspec/rspec-rails) for testing
- factory_bot for test fixtures
- [strong_migrations](https://github.com/ankane/strong_migrations) for helping me understand if I'm writing a bad migration or not
- Code formatting
  - [Prettier](https://prettier.io/)
  - [standard](https://github.com/testdouble/standard)
  - Auto-formatting and linting as a pre-commit hook

## Setup

First clone this repo to your local machine. Then run the following command

```sh
yes | rails new app_name -f -m /path/to/rails-template/template.rb -T -j esbuild -c tailwind -d postgresql
```

Explaning the arguments:

- `yes |` - Answers yes when the [bullet](https://github.com/flyerhzm/bullet) gem asks if Bullet should be installed during tests.
- `app_name` - Replace with the app name / directory you want the Rails app to be placed in.
- `-f` - Force any templates to be overridden (this prefers my Tailwind config over the Rails default config).
- `-m /path/to/rails-template/template.rb` - use this Rails template
- `-T` - Skip generating default Rails tests. This is because I will install RSpec separately.
- `-j esbuild` - Use esbuild to bundle JavaScript.
- `-c tailwind` - Use Tailwind as the CSS framework.
- `-d postgresql` - Use the PostgreSQL database.
