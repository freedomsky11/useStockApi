class StocksController < ApplicationController
  def index
    @gid = "---"
    @name = "---"
    @todayStartPri = "---"
    @yestodEndPri = "---"
    @nowPri = "---"
    @todayMax = "---"
    @todayMin = "---"
    @increase = "---"
    @increPer = "---"
    @traNumber = "---"
    @traAmount = "---"
    @gopicture
    if params[:stocknumber]
      response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hs", :params => { :gid => "sh" + params[:stocknumber], :key => JUHE_CONFIG["api_key"] }
      data = JSON.parse(response.body)
      if data["resultcode"] == "200"
        @gid = data["result"][0]["data"]["gid"].to_s
        @name = data["result"][0]["data"]["name"]
        @todayStartPri = data["result"][0]["data"]["todayStartPri"]
        @yestodEndPri = data["result"][0]["data"]["yestodEndPri"]
        @nowPri = data["result"][0]["data"]["nowPri"]
        @todayMax = data["result"][0]["data"]["todayMax"]
        @todayMin = data["result"][0]["data"]["todayMin"]
        @increase = data["result"][0]["data"]["increase"]
        @increPer = data["result"][0]["data"]["increPer"]
        @traNumber = data["result"][0]["data"]["traNumber"]
        @traAmount = data["result"][0]["data"]["traAmount"]
        @gopicture = data["result"][0]["gopicture"]["monthurl"]
      else
        response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hs", :params => { :gid => "sz" + params[:stocknumber], :key => JUHE_CONFIG["api_key"], :type => 1 }
        data = JSON.parse(response.body)
        if data["resultcode"] == "200"
          @gid = data["result"][0]["data"]["gid"]
          @name = data["result"][0]["data"]["name"]
          @todayStartPri = data["result"][0]["data"]["todayStartPri"]
          @yestodEndPri = data["result"][0]["data"]["yestoEndPri"]
          @nowPri = data["result"][0]["data"]["nowPri"]
          @todayMax = data["result"][0]["data"]["todayMax"]
          @todayMin = data["result"][0]["data"]["todayMin"]
          @increase = data["result"][0]["data"]["increase"]
          @increPer = data["result"][0]["data"]["increPer"]
          @traNumber = data["result"][0]["data"]["traNumber"]
          @traAmount = data["result"][0]["data"]["traAmount"]
          @gopicture = data["result"][0]["gopicture"]["monthurl"]
        else
          response = RestClient.get "http://web.juhe.cn:8080/finance/stock/hk", :params => { :num => params[:stocknumber], :key => JUHE_CONFIG["api_key"]}
          data = JSON.parse(response.body)
          if data["resultcode"] == "200"
            @gid = data["result"][0]["data"]["gid"]
            @name = data["result"][0]["data"]["name"]
            @todayStartPri = data["result"][0]["data"]["openpri"]
            @yestodEndPri = data["result"][0]["data"]["formpri"]
            @nowPri = data["result"][0]["data"]["lastestpri"]
            @todayMax = data["result"][0]["data"]["maxpri"]
            @todayMin = data["result"][0]["data"]["minpri"]
            @increase = data["result"][0]["data"]["uppic"]
            @increPer = data["result"][0]["data"]["limit"]
            @traNumber = data["result"][0]["data"]["traNumber"]
            @traAmount = data["result"][0]["data"]["traAmount"]
            @gopicture = data["result"][0]["gopicture"]["monthurl"]
          else
            response = RestClient.get "http://web.juhe.cn:8080/finance/stock/usa", :params => { :gid => params[:stocknumber], :key => JUHE_CONFIG["api_key"]}
            data = JSON.parse(response.body)
            if data["resultcode"] == "200"
              @gid = data["result"][0]["data"]["gid"]
              @name = data["result"][0]["data"]["name"]
              @todayStartPri = data["result"][0]["data"]["openpri"]
              @yestodEndPri = data["result"][0]["data"]["formpri"]
              @nowPri = data["result"][0]["data"]["lastestpri"]
              @todayMax = data["result"][0]["data"]["maxpri"]
              @todayMin = data["result"][0]["data"]["minpri"]
              @increase = data["result"][0]["data"]["uppic"]
              @increPer = data["result"][0]["data"]["limit"]
              @traNumber = data["result"][0]["data"]["traAmount"]
              @traAmount = "---"
              @gopicture = data["result"][0]["gopicture"]["monthurl"]
            end
          end
        end
      end
    end
  end
end
