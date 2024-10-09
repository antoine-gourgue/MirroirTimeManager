defmodule Theme01Web.ErrorJSONTest do
  use Theme01Web.ConnCase, async: true

  test "renders 404" do
    assert Theme01Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Theme01Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
