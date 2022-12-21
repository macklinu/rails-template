# rails-template

> My preferred template for getting started with [Rails][]

What's in the box?

- [Devise][] for user authentication
- UUIDs as the default model ID type
- [Tailwind][] for CSS
- PostgreSQL database
- esbuild for bundling JS assets
- [strong_migrations][] for helping me understand if I'm writing a bad migration or not
- Code formatting
  - [Prettier](https://prettier.io/)
  - [standard](https://github.com/testdouble/standard)
  - Auto-formatting and linting as a pre-commit hook using [husky][] and [lint-staged][]

## Setup

First clone this repo to your local machine. Then run the following command

```sh
yes | rails new app_name -f -m /path/to/rails-template/template.rb -j esbuild -c tailwind -d postgresql
```

Explaning the arguments:

- `yes |` - Answers yes when the [bullet][] gem asks if Bullet should be installed during tests.
- `app_name` - Replace with the app name / directory you want the Rails app to be placed in.
- `-f` - Force any templates to be overridden (this prefers my Tailwind config over the Rails default config).
- `-m /path/to/rails-template/template.rb` - use this Rails template
- `-j esbuild` - Use esbuild to bundle JavaScript.
- `-c tailwind` - Use Tailwind as the CSS framework.
- `-d postgresql` - Use the PostgreSQL database.

[bullet]: https://github.com/flyerhzm/bullet
[devise]: https://github.com/heartcombo/devise
[husky]: https://github.com/typicode/husky
[lint-staged]: https://github.com/okonet/lint-staged
[rails]: https://rubyonrails.org/
[strong_migrations]: https://github.com/ankane/strong_migrations
[tailwind]: https://tailwindcss.com/
