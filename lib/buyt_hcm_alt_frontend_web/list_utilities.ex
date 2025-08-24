defmodule BuytHcmAltFrontendWeb.ListUtilities do
  @moduledoc """
  Module housing utility for extra list manipulation operations.
  """

  @spec chunk_by_breakpoints(
          elements_list :: list(any()),
          breakpoints :: list(any())
        ) :: any()

  # doc suggested by claude (and copied over by hand since I'm not particularly smart).
  # This function was made by me with guidance from the Elixir community IRC chat room, and was moved to this specific module following a suggestion from Claude.
  @doc """
  Chunks a list at specified breakpoints inclusively.

  ## Example:

    iex> import BuytHcmAltFrontendWeb.ListUtilities
    iex> chunk_by_breakpoint([:a, :b, :c, :d, :e, :f], [:b, :e, :f])
    [[:a, :b], [:b, :c, :d, :e], [:e, :f]]

  """
  def chunk_by_breakpoints(elements_list, breakpoints) do
    # IO.inspect(binding())

    chunk_fun = fn
      element, {[], acc} ->
        {:cont, {[], [element | acc]}}

      element, {breakpoints, acc} ->
        [breakpoint | remaining_breakpoint] = breakpoints

        if element == breakpoint do
          {
            :cont,
            Enum.reverse([element | acc]),
            {remaining_breakpoint, [element]}
          }
        else
          {
            :cont,
            {breakpoints, [element | acc]}
          }
        end
    end

    after_fun = fn
      {[], []} -> {:cont, {[], []}}
      {[], [_]} -> {:cont, {[], []}}
      {[], acc} -> {:cont, Enum.reverse(acc), nil}
    end

    Enum.chunk_while(elements_list, {breakpoints, []}, chunk_fun, after_fun)
  end

  def to_sentence(list, opts \\ []) when is_list(list) do
    separator = opts |> Keyword.get(:separator, ", ")
    last_separator = opts |> Keyword.get(:connector, " & ")
    case list do
      [] -> "¯\_(ツ)_/¯"
      [single] -> single |> to_string
      mutiple ->
        do_to_sentence(mutiple, separator, last_separator)
    end
  end

  defp do_to_sentence([last], _separator, last_separator) do
    to_string(last_separator) <> to_string(last)
  end
  defp do_to_sentence([thingy | rest], separator, last_separator) do
    to_string(thingy) <> do_to_sentence(List.wrap(rest), separator, last_separator)
  end
end
