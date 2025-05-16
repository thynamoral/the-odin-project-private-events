class EventsController < ApplicationController
  before_action :set_event, only: [ :show ]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = 1 # Mocking creator_id for now
    if @event.save
      redirect_to events_path, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end
    def event_params
      params.require(:event).permit(:title, :description, :date, :location, :creator_id)
    end
end
