class EventController < ApplicationController

  def create
    require 'securerandom'

    #イベントの登録
    @event = Event.new(
      title: params[:title],
      memo: params[:memo],
      candidate_date: params[:calendar],
      url: SecureRandom.urlsafe_base64,
      candidate_count: "0人"
    )
    #count = params[:calendar].count('\n')

    #イベントの保存処理
    if @event.save
      redirect_to("/events/create/#{@event.id}")
    else
      redirect_to("/meetings/index")
    end
  end

   def view
    @event = Event.find(params[:id])
  end

  def share
    @event = Event.find(params[:id])

    #イベントのURLが間違っていたらルートパスに戻す
    if @event.url != params[:url]
      flash[:notice] = "URLが間違っています"
      redirect_to(root_path)
    end

    #候補日を改行文字で区切る
    @event_s = @event.candidate_date.split("\r\n")

    name = ''
    status = ''
    @hash = {}
    if @event.candidate_count != '0人'
      name = @event.candidate_count.scan(/「name:(\w+)」/)
      status =@event.candidate_count.scan(/status:(\w+)/)

      #名前とステータスでhashをつくる
      name.each_with_index do |n,i|
        @hash.store(n,status[i].join.split("chk"))
      end
    end
  end

  def update
    @event = Event.find(params[:id])
    #参会者登録処理
    if params[:name] != nil
      @event.candidate_count += "///「name:" + params[:name] + 
                              "」//「status:" + params[:hidden_status_data] + 
                              "」"
      else
        render("/share/#{@event.id}/#{@event.url}")
    end

    #イベントの更新処理
    if @event.save
      #flash[:notice] = "登録しました"
      redirect_to("/share/#{@event.id}/#{@event.url}")
    else
      render("/share/#{@event.id}/#{@event.url}")
    end
  end

end
