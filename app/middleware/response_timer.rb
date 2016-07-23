class ResponseTimer
 def initialize(app)
      @app = app
    end
  
 # def call(env)
  
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["My Middleware"]]
  end 
  # start = Time.now
  # status, headers, response = @app.call(env)
  # stop = Time.now
  # [status, headers, "<!-- Response Time: #{stop - start} -->\n" + response.body]
  # end

end