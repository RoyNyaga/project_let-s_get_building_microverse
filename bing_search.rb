require 'rest-client'
matcher = /<h2><a.*?href="(?<link>.*?)".*?h=.*?>(?<text>.*?)<\/a.*?>/
puts "Welcome to Bing searcher!"
puts "The top ten results from Bing on your command line"

loop do
  puts "Type in word to search.  'quit' to Quit"
  word = gets.chomp
  break if word =~ /quit/i
  url = 'https://www.bing.com'
  response = RestClient.get url, {params: {q: word}}
  results = []
  response.body.scan(matcher) {results << $~}
  i = 1
  puts "-------------------------"
  puts "The results are:"
  results.each do |result|
    puts "#{i}. #{result[:text]}"
    puts " -- Link:#{result[:link]}"
    i += 1
  end
  puts "-------------------------"
end
