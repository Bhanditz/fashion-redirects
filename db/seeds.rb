# frozen_string_literal: true
[
  { src: '/', dst: '/portal/collections/fashion', site: 'portal' },
  { src: '/portal/home.html', dst: '/portal/collections/fashion', site: 'portal' },
  { src: '/portal/browse.html', dst: '/portal/collections/fashion?q=&from=europeanafashion.eu', site: 'portal' },
  { src: '/portal/themeoverview.html', dst: '/portal/explore/galleries?theme=fashion', site: 'portal' },
  { src: '/portal/themedetail.html', dst: '/portal/explore/galleries?theme=fashion&from=europeanafashion.eu', site: 'portal' },
  { src: '/portal/blogoverview.html', dst: '/portal/blogs?theme=fashion', site: 'portal' },
  { src: '/portal/eventoverview.html', dst: '/portal/events?theme=fashion', site: 'portal' },
  { src: '/portal/about.html', dst: '/europeana-fashion', site: 'pro' },
  { src: '/portal/contact.html', dst: '/europeana-fashion', site: 'pro' },
  { src: '/publications', dst: '/europeana-fashion', site: 'pro' },
  { src: '/publications/', dst: '/europeana-fashion', site: 'pro' },
  { src: '/press-releases', dst: '/europeana-fashion', site: 'pro' },
  { src: '/press-releases/', dst: '/europeana-fashion', site: 'pro' },
  { src: '/partners', dst: '/europeana-fashion', site: 'pro' },
  { src: '/partners/', dst: '/europeana-fashion', site: 'pro' }
].each do |attrs|
  redirect = Redirect.find_or_create_by(src: attrs[:src])
  redirect.dst = attrs[:dst]
  redirect.site = attrs[:site]
  redirect.save!
end

# Blog posts
#
# Redirect both URLs:
# * /blog/runway-archive-lapidus-autumn-winter-1996
# * /2017/03/23/runway-archive-lapidus-autumn-winter-1996/
# to:
# * /portal/en/blogs/[NEW-SLUG]
# where [NEW-SLUG] results from the import into Pro. Map of paths/slugs is in
# db/seeds/blog_posts.yml
YAML.load_file(File.expand_path('../seeds/blog_posts.yml', __FILE__)).each do |post|
  fashion_blog_host_src = post[:wp_src]
  fashion_portal_host_src = '/blog/' + post[:wp_src].split('/')[-1]

  collections_portal_host_dst = post[:pro_dst].sub(%r{\A/blogpost/}, '/portal/en/blogs/')

  [fashion_blog_host_src, fashion_portal_host_src].each do |src|
    redirect = Redirect.find_or_create_by(src: src)
    redirect.dst = collections_portal_host_dst
    redirect.site = 'portal'
    redirect.save!
  end
end

# Events
#
# Redirect URL:
# * /all-events/exhibition-brides-at-the-leventis-museum
# to:
# * /portal/en/events/[NEW-SLUG]
# where [NEW-SLUG] results from the import into Pro. Map of paths/slugs is in
# db/seeds/events.yml
YAML.load_file(File.expand_path('../seeds/events.yml', __FILE__)).each do |event|
  fashion_event_blog_host_src = event[:wp_src]

  collections_portal_host_dst = event[:pro_dst].sub(%r{\A/event/}, '/portal/en/events/')

  redirect = Redirect.find_or_create_by(src: fashion_event_blog_host_src)
  redirect.dst = collections_portal_host_dst
  redirect.site = 'portal'
  redirect.save!
end
