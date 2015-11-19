defmodule Struct.Api.StreamHookController do
  use Phoenix.Controller
  plug :action
  
  def check(conn, _params) do
    stream = false
    if _params["name"] && _params["key"] do
      user = Struct.Services.UserFind.call(id: _params["name"])
      if user do
        stream = Struct.Services.StreamFind.call(user: user)
      end
    end

    if stream && stream.streamkey == _params["key"] do
      Struct.Services.StreamStart.call(stream: stream)
      text conn, 200, "ok"
    else
      text conn, 403, "unknown stream key"
    end
  end


  def hook(conn, _params) do
    if _params["call"] == "play" do
      text conn, 200, "ok"
    else
      stream = false
      event = _params["call"]
      if _params["name"] && _params["key"] do
        user = Struct.Services.UserFind.call(id: _params["name"])
        if user do
          stream = Struct.Services.StreamFind.call(user: user)
        end
      end

      if stream do
        if event == "done", do: Struct.Services.StreamStop.call(stream: stream)
        if event == "record_done", do: Struct.Services.StreamRecord.call(stream: stream, path: _params["path"])
        text conn, 200, "ok"
      else
        text conn, 403, "unknown stream"
      end
    end
  end

end
