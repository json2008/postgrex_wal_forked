defmodule PostgrexWal.Message.Delete do
  @moduledoc """
  A delete message.
  """

  use TypedStruct

  typedstruct enforce: true do
    field :relation_id, integer()
    field :data, [map()]
  end

  def decode(<<relation_id::32, ?K, tuple_data::binary>>) do
    %__MODULE__{
      relation_id: relation_id,
      data: PostgrexWal.Message.TupleData.decode(tuple_data |> IO.inspect())
    }
  end

  def decode(<<relation_id::32, ?O, tuple_data::binary>>) do
    %__MODULE__{
      relation_id: relation_id,
      data: PostgrexWal.Message.TupleData.decode(tuple_data)
    }
  end
end
