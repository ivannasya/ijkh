# encoding: utf-8
class EnergosbytWorker
	include Sidekiq::Worker

	def perform(url, data)

		require 'net/http'

		publish_message = {}
		uri = URI.parse(url)
		http = Net::HTTP.new(uri.host, uri.port)
		post = Net::HTTP::Post.new(uri.path)
		post.body = data
		logger.info response = http.request(post)

	end

end