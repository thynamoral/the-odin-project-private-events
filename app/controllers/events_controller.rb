class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_event, only: [ :show, :attend, :unattend ]

  def index
    @events = Event.where("date >= ?", Date.today).order(date: :desc)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id
    if @event.save
      redirect_to events_path, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def attend
    attendance = @event.attendances.build(user: current_user)
    if attendance.save
      flash[:success] = "You have successfully registered for '#{@event.title}'"
      redirect_to @event
    else
      flash[:error] = "Unable to register for event: #{attendance.errors.full_messages.join(', ')}"
      redirect_to @event
    end
  end

  def unattend
    attendance = @event.attendances.find_by(user: current_user)
    if attendance&.destroy
      flash[:notice] = "You have canceled your registration for '#{@event.title}'"
      redirect_to @event
    else
      flash[:error] = "Unable to cancel registration"
      redirect_to @event
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
