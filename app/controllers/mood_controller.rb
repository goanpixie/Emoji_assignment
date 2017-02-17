
require 'json'
require 'net/http'
require 'open-uri'

class MoodController < ApplicationController

  $emoji_uri = 'https://api.github.com/emojis'

  def index
  	@error = flash[:error]
  end

  def show
  	uri = URI.parse($emoji_uri)
  	http = Net::HTTP.new(uri.host, uri.port)

  	http.use_ssl = true
  	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  	request = Net::HTTP::Get.new(uri.request_uri)
  	response = http.request(request)

  	data = response.body

  
  	@emoji = JSON.load(data)

	if @emoji[params[:mood]] 
		@emoji = @emoji[params[:mood]]
	else
		flash[:error] = 'I am sorry, I could not recognize your mood.  Please try again.'
		redirect_to root_path

	end

  end
end
