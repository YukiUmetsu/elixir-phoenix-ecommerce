# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mango.Repo.insert!(%Mango.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias NimbleCSV.RFC4180, as: CSV
alias Mango.Repo
alias Mango.Catalog.Product

Path.join(:code.priv_dir(:mango), "product_list.csv")
|> File.read!
|> CSV.parse_string
|> Enum.each(fn [_, name, price, sku, is_seasonal, image, pack_size, category] ->
  is_seasonal = String.to_existing_atom(is_seasonal)
  price = Decimal.new(price)
  %Product{ name: name, price: price, sku: sku, is_seasonal: is_seasonal, image: image, pack_size: pack_size, category: category}
  |> Repo.insert
end)