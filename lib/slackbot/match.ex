defmodule Exavier.Slackbot.Match do
  defmacro __using__(_opts) do
    quote do
      @regex_patterns []
      Module.register_attribute(__MODULE__, :regex_patterns, accumulate: true)

      import unquote(__MODULE__), only: [match: 2]

      @before_compile unquote(__MODULE__)

      def handle_message(message = %{type: "message", text: text}, slack, state) do
        IO.inspect message
        match!(message, slack, state)
      end
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def match!(message = %{text: text}, slack, state) do
        case find_regex_match(text) do
          {pattern, [m, f]} ->
            [_text | captures] = Regex.run(pattern, text)
            args = [message, slack, state]
            unless Enum.empty?(captures) do
              args = args ++ captures
            end
            apply(m, f, args)
          nil -> {:ok, state}
        end
      end

      defp find_regex_match(text) do
        Enum.find(@regex_patterns, fn {pattern, [m, f]} ->
          Regex.match?(pattern, text)
        end)
      end
    end
  end

  defmacro match(pattern, function) do
    {function, []} = Code.eval_quoted(function, [], __ENV__)
    [m, f] = case function do
               f when is_atom(f) -> [__CALLER__.module, f]
               [m, f] -> [m, f]
             end

    quote do
      @regex_patterns {unquote(pattern), [unquote(m), unquote(f)]}
    end
  end
end
