#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'rexml/document'

# 環境変数から認証情報を取得
hatena_id = ENV['HATENA_ID']
api_key = ENV['HATENA_API_KEY']
blog_id = ENV['HATENA_BLOG_ID']

# 引数から記事ファイルパスを取得
post_file = ARGV[0]

unless File.exist?(post_file)
  puts "Error: Post file not found: #{post_file}"
  exit 1
end

# 記事ファイルを読み込む
content = File.read(post_file)

# Front matterとコンテンツを分離
if content =~ /\A---\s*\n(.*?)\n---\s*\n(.*)\z/m
  front_matter = $1
  body = $2
else
  puts "Error: Invalid post format (no front matter found)"
  exit 1
end

# Front matterからタイトルとタグを抽出
title = front_matter[/^title:\s*(.+)$/, 1]&.strip&.gsub(/^["']|["']$/, '')
tags_match = front_matter[/^tags:\s*\[(.+)\]/, 1]
tags = tags_match ? tags_match.split(',').map(&:strip) : []
categories_match = front_matter[/^categories:\s*(.+)$/, 1]
categories = categories_match ? categories_match.strip.split(/\s+/) : []
all_tags = (tags + categories).uniq

unless title
  puts "Error: Title not found in front matter"
  exit 1
end

puts "Title: #{title}"
puts "Tags: #{all_tags.join(', ')}"

# はてなブログのAtomPub APIエントリを作成
entry = REXML::Document.new
entry << REXML::XMLDecl.new('1.0', 'UTF-8')

entry_elem = entry.add_element('entry', {
  'xmlns' => 'http://www.w3.org/2005/Atom',
  'xmlns:app' => 'http://www.w3.org/2007/app'
})

entry_elem.add_element('title').text = title
entry_elem.add_element('content', {'type' => 'text/x-markdown'}).text = body

# カテゴリ（タグ）を追加
all_tags.each do |tag|
  entry_elem.add_element('category', {'term' => tag})
end

# 下書きとして投稿
entry_elem.add_element('app:control').add_element('app:draft').text = 'yes'

# APIエンドポイント
api_url = "https://blog.hatena.ne.jp/#{hatena_id}/#{blog_id}/atom/entry"
uri = URI.parse(api_url)

# HTTP Basic認証を使用
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.path)
request.basic_auth(hatena_id, api_key)
request['Content-Type'] = 'application/xml'
request.body = entry.to_s

puts "\nPosting to Hatena Blog..."
puts "API URL: #{api_url}"

response = http.request(request)

if response.code == '201'
  puts "\n✓ Successfully posted to Hatena Blog as draft!"

  # レスポンスから記事URLを取得
  response_doc = REXML::Document.new(response.body)
  edit_url = response_doc.elements['//link[@rel="edit"]']&.attributes['href']
  alternate_url = response_doc.elements['//link[@rel="alternate"]']&.attributes['href']

  puts "Edit URL: #{edit_url}" if edit_url
  puts "Post URL: #{alternate_url}" if alternate_url
else
  puts "\n✗ Failed to post to Hatena Blog"
  puts "Status: #{response.code} #{response.message}"
  puts "Response: #{response.body}"
  exit 1
end
