# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def welcome_mail_preview
		UserMailer.welcome_email(User.first)
	end

	def new_bet_mail_preview
		UserMailer.new_bet_email(User.find_by(id: 1), User.find_by(id: 2))
	end

	def bet_accepted_preview
		UserMailer.bet_accepted_email(User.find_by(id: 1), User.find_by(id: 2), Bet.find_by(id: 1))
	end
end
