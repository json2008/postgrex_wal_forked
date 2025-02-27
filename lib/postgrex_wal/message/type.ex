defmodule PostgrexWal.Message.Type do
  @moduledoc """
  A begin message
  """
  defstruct ~W[id namespace name]a

  def decode(<<data_type_id::integer-32, namespace_and_name::binary>>) do
    [namespace, name_with_null] = :binary.split(namespace_and_name, <<0>>)
    name = String.slice(name_with_null, 0..-2)

    %__MODULE__{
      id: data_type_id,
      namespace: namespace,
      name: name
    }
  end
end
