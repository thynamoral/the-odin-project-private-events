class AttendancesController < ApplicationController
  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to @attendance.event, notice: "Attendanced the event successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def attendance_params
    params.require(:attendance).permit(:event_id, :user_id)
  end
end
