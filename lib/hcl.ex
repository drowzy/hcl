defmodule HCL do
  @moduledoc """
  Documentation for `HCL`.
  """

  @doc """
  """
  @spec from_file(Path.t()) :: {:ok, HCL.Ast.Body.t()} | {:error, term()}
  def from_file(path) do
    with {:ok, bin} <- File.read(path),
         {:ok, _body} = return <- HCL.Parser.parse(bin) do
      return
    end
  end

  @doc """
  """
  @spec from_file!(Path.t()) :: HCL.Ast.Body.t()
  def from_file!(path) do
    case from_file(path) do
      {:ok, body} -> body
      {:error, reason} -> raise "err #{inspect(reason)}"
    end
  end

  @doc """
  """
  @spec from_binary(binary()) :: {:ok, HCL.Ast.Body.t()} | {:error, term()}
  def from_binary(bin) do
    with {:ok, _body} = return <- HCL.Parser.parse(bin) do
      return
    end
  end

  @spec from_binary!(binary()) :: HCL.Ast.Body.t()
  def from_binary!(bin) do
    case from_binary(bin) do
      {:ok, body} ->
        body

      {:error, reason, {line, _line_offset}, _} ->
        raise "err #{inspect(reason)} line: #{inspect(line)}"
    end
  end
end
