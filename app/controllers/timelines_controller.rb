# frozen_string_literal: true

class TimelinesController < ApplicationController
  before_action :set_timeline, only: %i[show update destroy]

  def index
    @timelines = Timeline.all
  end

  def show; end

  def create
    @timeline = Timeline.new(timeline_params)

    if @timeline.save
      render :show, status: :created, location: @timeline
    else
      render json: @timeline.errors, status: :unprocessable_entity
    end
  end

  def update
    if @timeline.update(timeline_params)
      render :show, status: :ok, location: @timeline
    else
      render json: @timeline.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @timeline.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_timeline
    @timeline = Timeline.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def timeline_params
    params.fetch(:timeline, {})
  end
end
