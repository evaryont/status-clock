class ClocksController < ApplicationController
  before_action :set_clock, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:create, :new, :update]

  # GET /clocks
  # GET /clocks.json
  def index
    @clocks = Clock.all
  end

  # GET /clocks/1
  # GET /clocks/1.json
  def show
  end

  # GET /clocks/new
  def new
    @clock = Clock.new
  end

  # GET /clocks/1/edit
  def edit
  end

  # POST /clocks
  # POST /clocks.json
  def create
    clock_saved = Clock.init_with_statuses(current_user, clock_params[:lcd_count])

    if clock_saved
      redirect_to root_path, notice: 'Clock was successfully created.'
    else
      redirect_to action: 'new'
    end
  end

  # PATCH/PUT /clocks/1
  # PATCH/PUT /clocks/1.json
  def update
    used_hands = {0 => true}.merge(Hash[ @clock.users.map { |user| [ user.hand, user ] } ] )
    updated = @clock.update(clock_params)

    # ...this is messy.
    # Set each chosen user's hand
    clock_params[:user_ids].each do |user_id|
      next if user_id.empty?
      user = User.find user_id.to_i
      Rails.logger.debug "User #<#{user.name}:#{user.id}>.. checking for reset & balancing hands"

      # Delete the user's status if it is pointing to a different clock
      unless @clock.statuses.include? user.status
        user.status = nil
        user.status_id = nil
        user.hand = nil # And make sure to delete their hand for the following code
        updated = user.save and updated 
        Rails.logger.debug "User #<#{user.name}:#{user.id}> has been reset"
      end

      # Check to see if the user already has an associated hand index
      if !user.hand.nil? && used_hands[user.hand].nil?
        used_hands[user.hand] = user
        Rails.logger.debug "First come, first serve: #<#{user.name}:#{user.id}> has hand #{user.hand}"
      else
        # Oh, that hand index has already has a user associated to it, so now we
        # need to find the missing number (e.g. 1,3,4 it would be 2) and give it
        # to the user
        used_hands.keys.max.to_i.times do |hand_number|
          Rails.logger.debug "Checking hands for #{hand_number}+1 (which is #{used_hands.keys.include?(hand_number+1) ? '' : 'NOT ' }included)"
          unless used_hands.keys.include? hand_number+1
            # Found it! Set it and break out of the loop
            user.hand = hand_number+1
            used_hands[user.hand] = user
            Rails.logger.debug "User #<#{user.name}:#{user.id}> has their hand set to a missing number: #{user.hand}"
            break
          end
        end

        # Still no number yet? Give it the max + 1 (1,2,3 then it'll be 4)
        if user.hand.nil?
          max_hand = used_hands.keys.max.to_i
          user.hand = max_hand + 1
          used_hands[user.hand] = user
          Rails.logger.debug "User #<#{user.name}:#{user.id}> has no hand, setting to #{user.hand} (max was #{max_hand})"
        end
      end
      updated = user.save and updated 
    end

    respond_to do |format|
      if @clock.update(clock_params)
        format.html { redirect_to @clock, notice: 'Clock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit', alert: 'There was an issue updating the clock.' }
        format.json { render json: @clock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clocks/1
  # DELETE /clocks/1.json
  def destroy
    @clock.destroy
    respond_to do |format|
      format.html { redirect_to clocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clock
      @clock = Clock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clock_params
      params.require(:clock).permit!#(:user_ids, :status_ids, :lcd_count)
    end
end
