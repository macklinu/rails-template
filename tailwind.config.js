module.exports = {
  content: [
    './app/{components,views}/**/*.html.erb',
    './app/{components,helpers}/**/*.rb',
    './app/javascript/**/*.js',
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/line-clamp'),
  ],
}
