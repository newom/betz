class UserMailer < ApplicationMailer

	default from: "betzgge@gmail.com"

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: "WELCOME to the final table . . .")
	end

	def new_bet_email(sender, receiver)
		@sender = sender
		@receiver = receiver
		#url
		mail(to: @receiver.email, subject: "#{@sender.un} has sent a bet!!!")
	end

	def bet_accepted_email(sender, receiver, bet)
		@sender = User.find(sender)
		@receiver = User.find(receiver)
		@bet = bet
		mail(to: @sender.email, subject: "#{@receiver.un} has accepted your bet!")
	end

	def bet_rejected_email(sender, receiver, bet)
		@sender = User.find(sender)
		@receiver = User.find(receiver)
		@bet = bet
		mail(to: @sender.email, subject: "#{@receiver.un} has rejected your bet.")
	end
end
