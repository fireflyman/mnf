class RepliesController < ApplicationController
 before_filter :load_topic
 

  # GET /replies/new
  # GET /replies/new.xml
  def new
    @reply = @topic.replies.build

    respond_to do |format|
      format.html # new.html.erb
      #format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = @topic.replies.find(params[:id])
  end

  # POST /replies
  # POST /replies.xml
  def create
    @forum = @topic.forum
    @reply = @topic.replies.build(params[:reply])

    respond_to do |format|
      if @reply.save
        flash[:notice] = 'Reply was successfully created.'
        format.html { redirect_to(@topic) }
        #format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
       # format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.xml
  def update
    @forum = @topic.forum
    @reply = @topic.replies.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        flash[:notice] = 'Reply was successfully updated.'
        format.html { redirect_to(@topic) }
       # format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        #format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.xml
  def destroy
    @topic.replies.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to(@topic) }
     # format.xml  { head :ok }
    end
  end
protected
 def load_topic
  @topic = Topic.find(params[:topic_id])
 end
 
end
