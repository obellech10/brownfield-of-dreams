class ActivationMailer < ApplicationMailer
  default from: 'activations@turing_tutorials.com'

  def activation_email(user)
    # binding.pry
    @user = user
    @url = "localhost:3000/activation/#{@user.id}"
    # @url  = "ENV['ACTIVATION_URL']/activation/#{@user.id}"
    mail(to: @user.email, subject: 'Confirm Registration')
  end
end
