# Europeana Fashion Redirects

Sinatra app to handle redirects for Europeana Fashion URLs

## Configuration

Fashion hashes and equivalent Europeana record IDs are expected to be stored in
PostgreSQL.

Set one of the environment variables `DATABASE_URL` or `POSTGRES_URI` to the URI
of the PostgreSQL database, e.g.
`DATABASE_URL="postgres://fashion@localhost/fashion_redirects"`. If both are set,
`POSTGRES_URI` will take precedence.

Initialise the database with `bundle exec rake db:setup`. The seed script will
add an initial set of static page redirects.

To further populate the database with redirects for Europeana Fashion from the
Europeana Search/Record API, set your API key in the environment variable
`API_KEY` then use `bundle exec rake fashion:items`.

## Usage

Start the app using Puma: `bundle exec puma -C config/puma.rb`

## License

Licensed under the EUPL V.1.1.

For full details, see [LICENSE.md](LICENSE.md).
