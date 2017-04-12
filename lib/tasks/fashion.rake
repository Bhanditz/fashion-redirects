namespace :fashion do
  desc 'Crawls the Europeana API for Fashion items and inserts/updates them in the db'
  # @todo handle deleted items, by maintaining a tmp log of items returned from
  #   the API crawl
  task :items do
    Rake::Task['db:load_config'].invoke

    fail 'API_KEY env var is required.' unless ENV.key?('API_KEY')
    Europeana::API.key = ENV['API_KEY']

    cursor_log = File.expand_path('../../../log/cursor.log', __FILE__)
    if File.exists?(cursor_log)
      cursor = File.read(cursor_log).strip
      puts "Resuming from cursor #{cursor}"
    else
      cursor = '*'
    end

    i = 0

    while !cursor.nil?
      File.write(cursor_log, cursor, mode: 'w+')

      results = Europeana::API.record.search(query: 'PROVIDER:"Europeana Fashion"', rows: 100, cursor: cursor, profile: 'minimal')
      break unless results.key?(:items)

      results[:items].each do |item|
        i = i + 1
        print "[#{i}] "

        id = item[:id]

        redirect_uri = URI.parse(item[:edmIsShownAt].first)
        edm_is_shown_at_uri = URI.parse(CGI.parse(redirect_uri.query)['shownAt'].first)

        if edm_is_shown_at_uri.host == 'www.europeanafashion.eu'
          src = edm_is_shown_at_uri.path
        else
          record = Europeana::API.record.fetch(id: id)
          fashion_portal_web_resource = record['object']['aggregations'].first['webResources'].detect { |wr| wr[:about].start_with?('http://www.europeanafashion.eu/record/') }

          if fashion_portal_web_resource.nil?
            puts "no www.europeanafashion.eu web resource for item #{id}; skipping"
            next
          end

          fashion_portal_uri = URI.parse(fashion_portal_web_resource[:about])
          src = fashion_portal_uri.path
        end

        dst = "/portal/record#{id}.html"
        puts "#{src} => #{dst}"

        Redirect.find_or_create_by(src: src).tap do |redirect|
          redirect.dst = dst
          redirect.site = 'portal'
          redirect.save!
        end
      end

      cursor = results['nextCursor']
    end
  end
end
