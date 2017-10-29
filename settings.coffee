url = 'https://hanzo.io'

description = """
  Ticketing Example Using Hanzo and Picatic
  """

twitter =
  username: ''
  hashtags: 'hanzo,shopjs,javascript,coffeescript'
  text:     ''

facebook =
  username: ''

module.exports =
  site:
    title:     'Ticketing App'
    name:      'Ticketing App'
    url:       url
    copyright: ''

  meta:
    description: description

    facebook:
      appid:       '1648878842071733'
      description: description
      # image:       'https://getshopjs.com/img/logo.png'
      title:       'Get Ticketing App'

    twitter:
      description: description
      # image:       'https://getshopjs.com/img/logo.png'
      title:       'Get Ticketing App'

  social:
    twitter:
      username:  "@#{twitter.username}"
      shareLink: "https://twitter.com/intent/tweet?url=#{encodeURIComponent url}&text=#{encodeURIComponent twitter.text}&hashtags=#{twitter.hashtags}&via=#{twitter.username}&original_referer=#{encodeURIComponent url}"
    facebook:
      username:  facebook.username
      shareLink: 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent url
    googlePlus:
      shareLink: 'https://plus.google.com/share?url=' + encodeURIComponent url

