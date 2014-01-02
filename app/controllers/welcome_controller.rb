class WelcomeController < ApplicationController
  def index
    p current_user
    if current_user
      p "logged in!!"
    end
  end
end
