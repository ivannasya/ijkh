# encoding: utf-8 

class WebInterface::QuizController < WebInterfaceController
	def show
		@h = { 0 => "а) ",  1 => "б) ",  2 => "в) ",  3 => "г) ",  4 => "д) ",  5 => "е) ",  6 => "ж) ",  7 => "з) ",  8 => "и) ",  9 => "к) " }
		@quiz_q = QuizQuestion.select("id, body").order("id ASC")
		@quiz_a = QuizAnswer.select("id, body, quiz_question_id")

		#@services = @place.services.order("id DESC")
	end


end