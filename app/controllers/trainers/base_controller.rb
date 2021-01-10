# frozen_string_literal: true

class Trainers::BaseController < ApplicationController
  protected

  def find_current_user(payload)
    @current_user = Trainer.find(payload[:trainer_id])
  end
end
