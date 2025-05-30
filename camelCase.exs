Mix.install([
  {:nimble_parsec, "~> 1.0"}
])

defmodule CamelCase do
  import NimbleParsec

  lowercase = ascii_char([?a..?z])
  uppercase = ascii_char([?A..?Z])
  word_start = concat(uppercase, repeat(lowercase)) |> reduce({List, :to_string, []})
  first_word = concat(lowercase, repeat(lowercase)) |> reduce({List, :to_string, []})

  camel_case =
    concat(first_word, times(word_start, min: 1))

  defparsec(
    :parse_camel_case,
    camel_case
    |> reduce({Enum, :join, ["_"]})
    |> reduce({Enum, :map, [&String.downcase/1]})
  )

  # A helper function to check if parsing was successful
  # def parse(input) do
  #   case parse_camel_case(input) do
  #     {:ok, [[result]], _, _, _, _} -> {:change, result, :original, input}
  #     _ -> {:nochange, input}
  #   end
  # end

  def parse(input) do
    case parse_camel_case(input) do
      {:ok, [[result]], _, _, _, _} ->
        result <> " "

      _ ->
        input <> " "
    end
  end

  def parse_line(line) do
    String.split(line)
    |> Enum.map(fn word -> parse(word) end)
    |> List.insert_at(-1, "\n")
  end

  def parse_lines(lines) do
    Enum.map(lines, fn line -> parse_line(line) end)
    |> Enum.map(fn line -> line end)
    |> write_file()
  end

  def open_file(file_path \\ "camel_case_test_lines.txt") do
    case File.read(file_path) do
      {:ok, content} ->
        String.split(content, "\n", trim: true)

      {:error, reason} ->
        {:error, "Failed to open file: #{reason}"}
    end
  end

  def write_file(lines, target_file \\ "camel_case_test_lines.edit") do
    case File.open(target_file, [:write, :utf8]) do
      {:ok, target} ->
        Enum.each(lines, fn line -> IO.write(target, line) end)

        File.close(target)
        IO.puts("Successfully wrote to #{target_file}")

      {:error, reason} ->
        {:error, "Failed to open target file: #{reason}"}
    end
  end
end

# IO.puts(CamelCase.parse("happyDays"))
# IO.puts(CamelCase.parse("reallyHappyDaysAreHere"))
# IO.inspect(CamelCase.parse_line("here is the first line of the textString."))

CamelCase.open_file()
|> CamelCase.parse_lines()
