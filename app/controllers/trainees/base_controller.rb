# frozen_string_literal: true

class Trainees::BaseController < ApplicationController
  protected

  def find_current_user(payload)
    @current_user = Trainee.find(payload[:trainee_id])
  end
end
