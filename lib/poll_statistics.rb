class PollStatistics
	def self.fetch
		statistics = []
		statistics_el = {}
		poll_questions = WebInterface::QuizQuestion.all
		poll_questions.each do |pq|
			answers = []
			statistics_el[:quiz_question] = pq.as_json
			custom_answers = pq.quiz_results.select("custom_answer").where("custom_answer != ''").as_json
				if custom_answers.first
					statistics_el[:quiz_question].merge!(custom_answers: custom_answers)
				end
			poll_answers = pq.quiz_answers
			poll_answers.each do |pa|
				answer = pa.as_json
				answers_total = pa.quiz_results.count
				answer[:quiz_result] = {count: answers_total}
				answers << answer
			end
			statistics_el[:quiz_question][:quiz_answer] = answers
			statistics << statistics_el
			statistics_el = {}
			answers = []
		end
		return statistics
	end
end