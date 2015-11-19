defmodule Struct.Services.DateSerializer do
  use Timex

  def call(options) do
    date = options[:date]
    if date do
      DateFormat.format!(Date.from(Ecto.DateTime.to_erl(date)), "{ISOz}")
    else
      nil
    end
  end

end