defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, _workers) when length(texts) == 0 do %{} end
  def frequency(texts, workers) do
    task_count = ceil(length(texts) / workers)

    tasks = 
      texts
      |> Enum.chunk_every(task_count)
      |> Enum.map(fn group -> 
           Task.async(fn -> Enum.map(group, &frequency/1) end) end)
  
    results = Task.await_many(tasks)

    results 
    |> Enum.concat
    |> Enum.reduce(
      %{}, 
      fn(map, acc) -> 
        Map.merge(map, acc, fn _k, v1, v2 -> v1 + v2 end) end
    )
  end

  def frequency(text) do
    text 
    |> String.downcase 
    |> String.replace(~r/[\s!?:;,\.\-\\'"\(\)0-9]/, "")
    |> String.graphemes() 
    |> Enum.frequencies()
  end
end
